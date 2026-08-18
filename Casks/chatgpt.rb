cask "chatgpt" do
  arch arm: "arm64", intel: "amd64"

  version :latest
  sha256 :no_check

  url "https://persistent.oaistatic.com/codex-app-prod/linux/deb/latest/chatgpt_#{arch}.deb"
  name "ChatGPT"
  desc "Desktop app for Linux (preview)"
  homepage "https://learn.chatgpt.com/docs/linux/linux-app"

  depends_on formula: "dpkg"
  depends_on :linux
  container type: :naked

  suite "payload/usr/lib/chatgpt", target: "chatgpt"
  binary "#{appdir}/chatgpt/codex-launcher", target: "chatgpt"

  preflight do
    system_command "#{formula_opt_bin("dpkg")}/dpkg-deb",
                   args: ["-x", staged_path/"chatgpt_#{arch}.deb", staged_path/"payload"]
    FileUtils.rm staged_path/"chatgpt_#{arch}.deb"
  end

  postflight do
    xdg_data = Pathname.new(ENV["HOME"])/".local/share"
    (xdg_data/"applications").mkpath
    (xdg_data/"pixmaps").mkpath

    icon = xdg_data/"pixmaps/chatgpt.png"
    FileUtils.cp staged_path/"payload/usr/share/pixmaps/chatgpt.png", icon

    desktop_file = xdg_data/"applications/chatgpt.desktop"
    FileUtils.cp staged_path/"payload/usr/share/applications/chatgpt.desktop", desktop_file
    contents = desktop_file.read
    contents.sub!(%r{^Exec=.*$}, "Exec=#{appdir}/chatgpt/codex-launcher %U")
    contents.sub!(%r{^Icon=.*$}, "Icon=#{icon}")
    desktop_file.write contents

    FileUtils.rm_r(staged_path/"payload")
  end

  uninstall_postflight do
    FileUtils.rm_f [
      Pathname.new(ENV["HOME"])/".local/share/applications/chatgpt.desktop",
      Pathname.new(ENV["HOME"])/".local/share/pixmaps/chatgpt.png",
    ]
  end

  caveats <<~EOS
    The upstream download always serves the latest preview build, so Homebrew
    cannot detect new versions. To update to the latest build, run:
      brew upgrade --cask --greedy-latest leoxlin/craftbeer/chatgpt
  EOS
end

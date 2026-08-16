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
    FileUtils.rm_r(staged_path/"payload")
  end

  caveats <<~EOS
    The upstream download always serves the latest preview build, so Homebrew
    cannot detect new versions. To update to the latest build, run:
      brew upgrade --cask --greedy-latest leoxlin/craftbeer/chatgpt
  EOS
end

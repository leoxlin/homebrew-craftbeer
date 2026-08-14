class Lfg < Formula
  desc "Jump into a Git worktree and start a coding agent"
  homepage "https://github.com/leoxlin/lfg"
  url "https://github.com/leoxlin/lfg/releases/download/v0.5.1/lfg-0.5.1.tar.gz"
  sha256 "ac35bdd37c94fa6706fef095f49abefad9f5fc96249e50ee10fd3d2e48704048"

  depends_on "fzf"

  def install
    pkgshare.install Dir["*"]

    (pkgshare/"lfg.bash").append_lines <<~BASH

      function _lfg_update() {
        brew upgrade leoxlin/craftbeer/lfg
      }
    BASH
    (pkgshare/"lfg.zsh").append_lines <<~ZSH

      function _lfg_update() {
        brew upgrade leoxlin/craftbeer/lfg
      }
    ZSH
    (pkgshare/"functions/lfg.fish").append_lines <<~FISH

      function _lfg_update
          brew upgrade leoxlin/craftbeer/lfg
      end
    FISH

    fish_function.install_symlink pkgshare/"functions/lfg.fish", pkgshare/"functions/worktree.fish"
    fish_completion.install_symlink pkgshare/"completions/lfg.fish", pkgshare/"completions/worktree.fish"
  end

  def caveats
    <<~EOS
      To activate lfg, add the line for your shell to its startup file:

        Bash: source #{opt_pkgshare}/lfg.bash
        Zsh:  source #{opt_pkgshare}/lfg.zsh

      Fish functions and completions are installed automatically.
    EOS
  end

  test do
    output = shell_output("bash -c 'source #{pkgshare}/lfg.bash && lfg --version && worktree version'")
    assert_equal "lfg 0.5.1\nworktree 0.5.1\n", output

    (testpath/"bin").mkpath
    (testpath/"bin/brew").write <<~SH
      #!/bin/sh
      printf '%s\\n' "$*"
    SH
    chmod 0755, testpath/"bin/brew"
    ENV.prepend_path "PATH", testpath/"bin"
    assert_equal "upgrade leoxlin/craftbeer/lfg\n",
                 shell_output("bash -c 'source #{pkgshare}/lfg.bash && lfg --update'")

    assert_equal pkgshare/"functions/lfg.fish", (fish_function/"lfg.fish").realpath
    assert_equal pkgshare/"functions/worktree.fish", (fish_function/"worktree.fish").realpath
    assert_equal pkgshare/"completions/lfg.fish", (fish_completion/"lfg.fish").realpath
    assert_equal pkgshare/"completions/worktree.fish", (fish_completion/"worktree.fish").realpath
  end
end

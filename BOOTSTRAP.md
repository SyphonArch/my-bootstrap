# Bootstrap

Follow these stages in order using the process for the selected mode in
`AGENTS.md`. In `speedrun`, its overrides apply to every instruction below that
would otherwise require confirmation, backup, or additional validation.

Prefer pre-installed binaries. Validate them before proposing an install,
replacement, or upgrade. Confirm before replacing or bypassing one.

Before each install, report either the existing binary's path and version or the
proposed installation details. State which will be used and confirm.

In `sources/`, configurable regions use matching
`# !!! BOOTSTRAP_RESOLVE_BEGIN: NAME; suggested=VALUE !!!` and
`# !!! BOOTSTRAP_RESOLVE_END: NAME !!!` comments. Contents are provisional.
Inspect or ask the user, show and confirm the result, then remove both markers.
Names must match. Never install a file with unresolved markers.
`; suggested=VALUE` is optional; omission means no proposed value.

## Stage 0: Start the bootstrap agent

Before starting the agent, add the chosen public key to
`~/.ssh/authorized_keys` and verify SSH access.

Check Git, curl, and network access; install missing tools for the platform.
Follow the [Quick start](README.md#quick-start), complete Codex sign-in, and
select `bootstrap`, `reconcile`, `patch`, or `speedrun` mode.

## Stage 1: Inspect the system

This stage is read-only and may run outside tmux.

1. Report the Linux distribution and release.
2. Report the architecture: x86-64, ARM64, or other.
3. Report CPU model, sockets, cores per socket, threads per core, and logical
   CPUs.
4. Report total and available RAM and swap.
5. Report each GPU's model and memory, plus driver and reported CUDA
   compatibility versions. Do not install drivers.
6. Check sudo, then run `sudo -n true`; `-n` prevents a password prompt. Report
   whether sudo is absent, non-interactive, requires authentication, or denied.
7. Report available system package managers without selecting one.

## Stage 2: Establish the tmux session

- Install tmux if needed.
- Compare [`sources/tmux.conf`](sources/tmux.conf) with any existing config.
  Confirm an inspectable merge or backed-up replacement after showing the
  result, backup path, and rollback procedure.
- Start or adopt a named tmux session for the remaining work.
- Give the user the command needed to attach to it.

## Stage 3: Configure zsh

- Install zsh if needed.
- Install and validate Oh My Zsh after zsh if needed.
- If needed, clone `zsh-autosuggestions` and `zsh-syntax-highlighting` under
  `${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins`. Validate their paths against
  [`sources/zshrc`](sources/zshrc).
- Resolve every marked region in `sources/zshrc` and compare the result with any
  existing `~/.zshrc`.
- Retain applicable sections from [`sources/aliases`](sources/aliases), resolve
  markers, and compare with `~/.aliases`. Include applicable Conda wrappers now;
  report not-yet-installed dependencies as pending.
- Show and confirm the resulting `~/.zshrc` and `~/.aliases`.
- Apply them by approved merge or backed-up replacement.
- Validate both files and extensions. Source `zsh-syntax-highlighting` last.
- Make zsh the default shell

## Stage 4: Install Conda

- For a new install, confirm a Miniconda version and exact path under `$HOME`.
- Install and validate Miniconda without creating unspecified environments.
- Initialize Conda for zsh with `base` activated by default. Validate in a new
  zsh session.

## Stage 5: Configure GPU monitoring

- Inspect the GPU and driver state.
- Prefer a global gpustat from the system package manager. Confirm its source,
  version, command, and path.
- Otherwise, confirm a Conda environment and install it there. Do not silently
  fall back to another global Python installation.
- Validate gpustat against the available GPUs.

## Stage 6: Configure Slurm helpers

Run only on a Slurm node.

- Resolve every marked region in [`sources/slurm/sbatch.sh`](sources/slurm/sbatch.sh)
  and [`sources/slurm/nodes.sh`](sources/slurm/nodes.sh).
- Compare with existing `~/slurm/sbatch.sh` and `~/slurm/nodes.sh` files.
- Show and confirm both results, then apply them non-destructively at those
  paths.
- Validate both scripts and any retained `sb` and `sn` aliases.

## Stage 7: Configure Vim

- Install Vim if needed.
- Use [`SyphonArch/my-vimrc`](https://github.com/SyphonArch/my-vimrc). Reuse an
  existing checkout or confirm a clone path.
- Inspect its instructions, show the changes, confirm, and apply them.
- Start Vim once to install declared extensions. YouCompleteMe installs but does
  not build. Stop on prompts or failures.
- Build YouCompleteMe last. Check CMake, Make, Ninja, and other requirements;
  show paths, versions, options, and commands before confirmation, then compile
  and validate it in Vim.
- Validate the configuration and extensions.

## Stage 8: Configure yggdrasil

- Install rclone if needed.
- If lacking sudo privileges, install into `~/.local/bin`.
- Confirm `ygg`, `yggstat`, `yggoff`, and `yggcache` from `~/.aliases`.
- Pause for the user to configure the `yggdrasil` remote because credentials may
  appear. Do not configure it or inspect its secrets; ask what command or manual
  action the user will perform and wait.
- Validate only that the named remote exists, without showing its configuration.
- Create and validate `$HOME/yggdrasil`; confirm the functions use it.
- Report and confirm the VFS cache's absolute path, backing device, capacity,
  and write access. Do not assume it is on the home filesystem.
- Mount with `ygg` and validate with `yggstat`. Explain `yggoff` and `yggcache`
  before testing; do not purge data during validation.

## Stage 9: Configure GitHub tooling

- Report existing Git and `gh` paths and versions.
- Confirm the source, command, and path before installing either tool.
- Ask for Git identity and scope. Do not infer name, email, default branch,
  credential helper, or signing configuration.
- Pause for user-run GitHub authentication; never request credentials in chat.
- Configure HTTPS and the `gh` Git credential helper so Git reuses its login.
- Report credential storage without showing the value. Confirm before plaintext
  storage, including its path and risk.
- Validate Git and `gh` authentication without exposing credentials.

## Stage 10 (optional): Configure Hugging Face authentication

Run only when the user wants Hugging Face CLI authentication.

- Report any existing CLI path, version, and environment.
- If missing, confirm the method, source, command, environment, and path. Do not
  choose a Python or Conda environment silently.
- Pause for user-run authentication. Never request, place, or inspect a token.
- Validate status without showing credentials.

## Stage 11 (optional): Configure the CUDA Toolkit

Run only when the user wants a toolkit and a CUDA-capable GPU is available.

- Report existing toolkit installations and `nvcc` paths and versions. A
  driver's reported compatibility does not prove a toolkit is installed.
- Propose a compatible toolkit version, source, command, path, and environment
  changes for confirmation. Do not modify the GPU driver without separate
  explicit approval.
- Validate `nvcc` and compile and run a minimal CUDA program on the GPU.

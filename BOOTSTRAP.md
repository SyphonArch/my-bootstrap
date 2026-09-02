# Bootstrap

Follow these stages in order. Complete each stage and its substeps through the
multi-turn process defined in `AGENTS.md` before proceeding.

Prefer pre-installed binaries. Inspect and validate an existing binary before
proposing another installation, replacement, or upgrade. Do not replace or
bypass it without the user's confirmation.

Before every installation step, explicitly state whether a usable installation
was found. If one was found, report its binary path and version and state whether
it will be used. If none was found, explicitly state that a new installation is
being proposed before presenting the installation details for confirmation.

In files under `sources/`, configurable regions are bounded by matching
`# !!! BOOTSTRAP_RESOLVE_BEGIN: NAME; suggested=VALUE !!!` and
`# !!! BOOTSTRAP_RESOLVE_END: NAME !!!` comments. Commands inside the region are
provisional and must not be treated as approved defaults. Resolve each region by
inspecting the environment or asking the user, as appropriate, then report the
proposed result and obtain confirmation. Keep or modify the approved commands and
remove both boundary comments. The begin and end names must match. Do not install
a source file while any `BOOTSTRAP_RESOLVE_BEGIN` or `BOOTSTRAP_RESOLVE_END`
comments remain. The `; suggested=VALUE` portion is optional; its absence means
that the repository proposes no value.

## Stage 0: Start the bootstrap agent

This is the only stage performed before the agent is running. First, add the
chosen public key to `~/.ssh/authorized_keys` and verify SSH access.

Follow the canonical [Quick start](README.md#quick-start) commands in
`README.md`. Before cloning, check whether Git and curl are installed. If either
is not, the person performing this stage must install it using the appropriate
platform mechanism, then confirm both are available before continuing. The
quick start also requires network access.
Complete the interactive Codex sign-in, select `bootstrap`, `reconcile`, or
`patch` mode, and continue with the requested scope.

## Stage 1: Inspect the server

This read-only inspection stage may be performed outside tmux. Do not make
system or configuration changes during it.

1. Determine and report the Linux distribution name and release.
2. Determine and report whether the CPU architecture is x86-64, ARM64, or
   another architecture.
3. Report the CPU model, socket count, cores per socket, threads per core, and
   total logical CPU count.
4. Report total and available RAM and swap.
5. Report every detected GPU, including its model and memory. Report the GPU
   driver version and its reported CUDA compatibility version when applicable.
   Do not install a driver during this stage.
6. Check whether sudo exists, then run `sudo -n true`. The `-n` option prevents
   sudo from prompting for a password. Report whether sudo is absent, succeeds
   without interaction, requires user authentication, or is denied by policy.
7. Determine and report every available system package manager. Do not select
   one yet.

## Stage 2: Establish the tmux session

- Install tmux if needed.
- Review the provided [`sources/tmux.conf`](sources/tmux.conf). Check for an
  existing tmux configuration and compare it with the provided file. Ask the
  user whether to apply the provided configuration on top of it or perform a
  backed-up replacement. Show the exact resulting configuration, backup path,
  and rollback procedure and obtain confirmation before making the change.
- Start or adopt a named tmux session for the remaining work.
- Give the user the command needed to attach to it.

## Stage 3: Configure zsh

- Install zsh if needed.
- After zsh is installed and validated, install Oh My Zsh if needed.
- Install `zsh-autosuggestions` and `zsh-syntax-highlighting` if needed by cloning
  their repositories into their corresponding directories under
  `${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins`. Validate both directories and
  confirm their paths match the source commands in
  [`sources/zshrc`](sources/zshrc).
- Resolve every marked region in `sources/zshrc` and compare the result with any
  existing `~/.zshrc`.
- From [`sources/aliases`](sources/aliases), retain only the sections whose
  applicability conditions are satisfied, resolve every marked region, and
  compare the result with any existing `~/.aliases`. Apply the Conda-dependent
  Vim and gpustat wrapper sections during this stage when their applicability
  conditions are satisfied, even though Conda, Vim, or gpustat may not be
  installed until later stages. Clearly report those dependencies as pending.
- Show the exact resulting `~/.zshrc` and `~/.aliases` and obtain confirmation
  before applying either file.
- Apply the approved results to `~/.zshrc` and `~/.aliases` using the approved
  non-destructive merge or backed-up replacement behavior.
- Configure and validate the user's shell, including loading both applied files
  and both extensions. Source `zsh-syntax-highlighting` last.

## Stage 4: Install Conda

- Use Miniconda for a new Conda installation. Select and approve its version and
  exact installation path, which must be under `$HOME`.
- Install and validate Miniconda without creating unspecified environments.
- Initialize Conda for zsh and configure the `base` environment to activate by
  default.
- Start a fresh zsh session and validate that `base` activates automatically.

## Stage 5: Configure GPU monitoring

- Inspect the GPU and driver state.
- First try to install gpustat globally through the selected system package
  manager. State the package source, version, command, and install location and
  obtain confirmation before installing it.
- If gpustat is unavailable from the system package manager, select and approve
  a Conda environment and install gpustat there. Do not use another global Python
  installation method as an unapproved fallback.
- Validate gpustat against the available GPUs.

## Stage 6: Configure Slurm helpers

This stage applies only when the machine is a Slurm node.

- Resolve every marked region in [`sources/slurm/sbatch.sh`](sources/slurm/sbatch.sh)
  and [`sources/slurm/nodes.sh`](sources/slurm/nodes.sh).
- Compare both resolved scripts with any existing `~/slurm/sbatch.sh` and
  `~/slurm/nodes.sh` files.
- Show the exact resulting scripts and obtain confirmation before applying them
  non-destructively at those paths.
- Validate both scripts and confirm that the `sb` alias, when retained, points to
  `~/slurm/sbatch.sh`.

## Stage 7: Configure Vim

- Install Vim if needed.
- Use the [`SyphonArch/my-vimrc`](https://github.com/SyphonArch/my-vimrc)
  repository as the source for the Vim configuration. Use an existing checkout
  if found; otherwise propose where to clone it and obtain confirmation.
- Inspect the repository's installation instructions and proposed changes, then
  obtain confirmation and apply the Vim configuration.
- Start Vim once and allow every extension declared by the vimrc, including
  YouCompleteMe, to install automatically. This installs YouCompleteMe but does
  not build it. Report any interactive prompts or failures and do not continue
  past them silently.
- After every extension has finished installing, treat the YouCompleteMe build
  as the final installation step. Inspect its build requirements and check for
  usable pre-installed build tools, including CMake, Make, and Ninja. Before
  installing missing tools or compiling YouCompleteMe, report their paths and
  versions, state the proposed build options and commands, and obtain
  confirmation.
- Compile YouCompleteMe last and validate that it loads successfully in Vim.
- Validate the resulting Vim configuration and all installed extensions.

## Stage 8: Configure yggdrasil

- Install rclone if needed.
- Confirm that the `ygg`, `yggstat`, `yggoff`, and `yggcache` functions from the
  applied `~/.aliases` are available.
- Treat configuration of the `yggdrasil` rclone remote as a sensitive user-action
  pause because it may request or display credentials. Do not configure the
  remote, request its secrets in chat, or inspect its credentials. Explain what
  must be configured, ask the user what command or manual action they want to
  perform, and wait for them to complete it and confirm the outcome.
- After the user confirms that the remote is configured, validate only that the
  named remote is available without displaying its configuration or credentials.
- Create and validate `$HOME/yggdrasil` as the mount location. Confirm that the
  applied yggdrasil functions use that exact path.
- Determine the effective rclone VFS cache location that `ygg` will use. Do not
  assume that it is on the home filesystem. Report its absolute path, backing
  filesystem or device, available capacity, and whether the user can write to
  it. Obtain explicit confirmation of the cache location before mounting.
- Use `ygg` to mount the remote, then validate the mount and the non-destructive
  behavior of `yggstat`. Explain `yggoff` and `yggcache` before asking whether the
  user wants to test them; do not purge cached data during validation.

## Stage 9: Configure GitHub tooling

- Inspect and report the existing Git and GitHub CLI (`gh`) installations,
  including their binary paths and versions.
- Install missing Git or GitHub CLI tooling through the selected system package
  manager after presenting the package source, command, and install location for
  confirmation.
- Ask the user to choose the Git identity and configuration scope. Do not infer
  or change the user's name, email address, default branch, credential helper,
  or signing configuration.
- Treat GitHub authentication as a sensitive user-action pause. Do not request a
  token or credential in chat. Explain the available login action, ask the user
  what command or manual action they want to perform, and wait for confirmation.
- Configure GitHub CLI to use HTTPS for Git operations and configure Git to use
  `gh` as its credential helper, so authenticated `git pull` and `git push`
  operations reuse the GitHub CLI credential.
- Determine and report how and where `gh` stored its credential without
  displaying the credential. If no secure credential store is available and
  `gh` will use plaintext storage, explain the path and risk and obtain explicit
  confirmation before proceeding.
- Validate Git and `gh` authentication without displaying credentials or
  authentication tokens.

## Stage 10 (optional): Configure Hugging Face authentication

Run this stage only when the user wants Hugging Face CLI authentication on this
machine.

- Inspect and report whether Hugging Face CLI tooling is already installed,
  including its binary path, version, and installation environment.
- If it is missing, present the available installation method, package source,
  command, environment, and install location and obtain confirmation before
  installing it. Do not choose a Python or Conda environment silently.
- Treat Hugging Face authentication as a sensitive user-action pause. Do not ask
  for an access token in chat, place one in a command, or inspect its stored
  value. Explain the required login action, ask the user what command or manual
  action they want to perform, and wait for confirmation.
- Validate authentication status without displaying the token or credential
  contents.

## Stage 11 (optional): Configure the CUDA Toolkit

Run this stage only when the user wants a CUDA Toolkit on this machine and a
CUDA-capable GPU is available.

- Inspect existing toolkit installations and report the `nvcc` path and version;
  do not confuse the driver's reported CUDA compatibility with an installed
  toolkit.
- Propose a compatible toolkit version, source, command, path, and environment
  changes for confirmation. Do not modify the GPU driver without separate
  explicit approval.
- Validate `nvcc` and compile and run a minimal CUDA program on the GPU.

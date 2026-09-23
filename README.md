# my-bootstrap

Human- (or agent-) readable instructions for bootstrapping and reconciling a
computing environment.

This public repository records my setup preferences across machines. It includes
directory names but no secrets.

A rushed bootstrap on a new machine takes about 30 minutes.

## Quick start

```sh
git clone https://github.com/SyphonArch/my-bootstrap.git
cd my-bootstrap
```

Select your AI agent. Install one, or install both and start either one to
continue.

Codex:

```sh
curl -fsSL https://chatgpt.com/codex/install.sh | sh
codex
```

Claude Code:

```sh
curl -fsSL https://claude.ai/install.sh | bash
claude
```

After the agent starts, select a mode and follow [`BOOTSTRAP.md`](BOOTSTRAP.md):

- `bootstrap`: Set up a new or intentionally clean environment.
- `reconcile`: Bring an existing environment into alignment.
- `patch`: Apply or reconcile only requested sections or subsections.
- `speedrun`: Set up an ephemeral server end to end with minimal interaction
  and only necessary functional checks.

## Contents

- [`AGENTS.md`](AGENTS.md): Interaction, confirmation, safety, and tmux rules.
- [`CLAUDE.md`](CLAUDE.md): Claude Code entry point that imports `AGENTS.md`.
- [`BOOTSTRAP.md`](BOOTSTRAP.md): The ordered setup procedure.
- [`sources/`](sources): Configuration sources and Slurm helper scripts to
  inspect, resolve, and apply during setup.

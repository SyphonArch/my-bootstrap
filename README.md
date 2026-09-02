# my-bootstrap

Human- (or agent-) readable instructions for bootstrapping and reconciling a
computing environment.

The instructions are inspectable and adaptable across hardware, operating
systems, and site-specific requirements.

This personal repository exposes directory names and setup preferences, but no
passwords, tokens, private keys, or other secrets.

## Quick start

```sh
git clone https://github.com/SyphonArch/my-bootstrap.git
cd my-bootstrap
curl -fsSL https://chatgpt.com/codex/install.sh | sh
codex
```

After Codex starts, select a mode and follow [`BOOTSTRAP.md`](BOOTSTRAP.md):

- `bootstrap`: Set up a new or intentionally clean environment.
- `reconcile`: Bring an existing environment into alignment.
- `patch`: Apply or reconcile only requested sections or subsections.

## Contents

- [`AGENTS.md`](AGENTS.md): Interaction, confirmation, safety, and tmux rules.
- [`BOOTSTRAP.md`](BOOTSTRAP.md): The ordered setup procedure.
- [`sources/`](sources): Configuration sources and Slurm helper scripts to
  inspect, resolve, and apply during setup.

Authentication is user-run and must not expose secrets in chat, commands, logs,
or configuration output.

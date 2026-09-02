# my-bootstrap

Human- (or agent-) readable instructions for bootstrapping and reconciling a
computing environment.

This public repository records my setup preferences across machines. It includes
directory names but no secrets.

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
- `speedrun`: Set up an ephemeral server end to end with minimal interaction
  and only necessary functional checks.

## Contents

- [`AGENTS.md`](AGENTS.md): Interaction, confirmation, safety, and tmux rules.
- [`BOOTSTRAP.md`](BOOTSTRAP.md): The ordered setup procedure.
- [`sources/`](sources): Configuration sources and Slurm helper scripts to
  inspect, resolve, and apply during setup.

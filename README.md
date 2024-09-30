# My Nixos Configuarion

## Author: msabeeh01

### Repo information

This is my basic nixos conf (for now) that is a good starting place for modularization, uses flakes, configuration.nix, and home-manager for best of all worlds but mainly depends on flakes/configuration.nix

### Why I use nixos?: Distrobox cannot run nixos but nixos can run Distrobox, plus other cool features in nixos like:

- nix-shell (try out stuff or create a FHS env for things that need it)
- rollbacks that makes stuff easy to repair
- declarative environments that ensure reproducability (good incase you blow something up)

### Why is my FHS nix-shell declared as such?

A workaround so that i could get PS1 to show i was using nix-shell while maintaining a FHS env and not a normal shell. Not tested besides for stuff i use.

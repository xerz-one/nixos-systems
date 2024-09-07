# nixos-systems

A Nix flake template that hopefully provides an intuitive way to define and manage multiple NixOS systems ❄️

## How does it hope to achieve that?

It's simple: first, you create a new flake using the template within this repo, for instance with:

```sh
nix flake new --template github:xerz-one/nixos-systems my-systems
```

Then, within the `systems` directory, you can place as many subdirectories containing a `default.nix` as you want. Each one will become... a NixOS system!

But before you get there, you need to actually declare the systems in question. The following are required for each system description:

- `root` and `inputs` as arguments for the system function
- Everything `nixpkgs.lib.nixosSystem` expects, mainly:
    - Importing the NixOS repository as the property `pkgs`
    - Defining the OS itself within the list of attribute sets named `modules`

An example called `hello` is included so you can quickly get started, even if you don't understand how from the explanation alone. There's also a `globals/system` path with a tiny few settings that might be handy, it's optional and you don't need to do anything at all to use them!

Once you've worked out all of the details and got something that you like and works, you're done! You can now start using `nix build`, `nixos-install`, `nixos-switch`, etc. with no extra hassle!

## Anything to keep in mind?

It tries to be as unopinionated as possible, limiting the required directory structure to its customized `lib` and the `systems` themselves, as well as an optional directory for `globals`. I *could* try to generalize `mkNixosConfig` a little bit more, but that remains to be seen.

I might end up adding additional templates with furtherly declared trees and complete system examples, who knows 🍿

Oh, and I used the [pipe operator](https://github.com/NixOS/rfcs/pull/148) all over the place for no particular reason, you're welcome – should be easy to replace if you prefer broader compatibility with Nix interpreters.
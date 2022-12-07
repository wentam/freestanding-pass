Tiny shell script gpg wrapper to access a [password store](https://www.passwordstore.org/)
without environmental dependency (no need to import keys with gpg).

Depends on gpg and pass.

Usage/examples:
```
freestanding-pass --keys /my/key1.asc /my/key2.asc --store /my/pass/store -- [arguments to pass]
freestanding-pass --keys /my/key1.asc /my/key2.asc --store /my/pass/store -- generate foo/bar
```


Nix users can try it with something like:
```
nix run github:wentam/freestanding-pass -- --keys /my/key1.asc /my/key2.asc --store /my/pass/store -- generate foo/bar
```

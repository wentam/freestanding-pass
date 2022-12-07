Tiny shell script gpg wrapper to access a [password store](https://www.passwordstore.org/)
without environmental dependency (no need to import keys with gpg).

Depends on gpg. Does not depend on pass.

Usage:
```
freestanding-pass my-gpg-key.asc /my/password/store my/password
```

Nix users can try it with: `nix run github:wentam/freestanding-pass -- my-gpg-key.asc /my/password/store my/password`

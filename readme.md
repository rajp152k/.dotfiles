# Stowed DotFiles

## Usage 

```
git clone https://github.com/rajp152k/.dotfiles ~/<desired loc>.dotfiles
cd <path to .dotfiles>/.dotfiles
stow <the utils you'd like to stow (pick and choose)>
```

## Secrets management

 - some tooling (emacs, bash, zsh) rely on a secrets file explicitly that I source/load in another parent config
 - I don't vc that (one shouldn't) : might push an sample.secrets.env of sorts sometime soon
 - in the actual config dirs (.config/<the util> usually) , the secrets are actual files whereas the rest of the configs are symbolic links

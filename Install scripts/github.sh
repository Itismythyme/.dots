mkdir -p ~/.ssh

chmod 700 ~/.ssh



nano ~/.ssh/whateveryouwant

paste private key and add public key to github

chmod 600 ~/.ssh/whateveryouwant



nano ~/.ssh/config

paste:

Host github.com

    HostName github.com

    User git

    IdentityFile ~/.ssh/dotfiles

    IdentitiesOnly yes



chmod 600 ~/.ssh/config

# Github Multi-Account
> **In the event that you need to manage a personal account and a business account**
- 1. Generate separate SSH keys for each account.

For the first account (“personal” or “accountName”):

```bash
ssh-keygen -t ed25519 -C “email@perso” -f ~/.ssh/id_ed25519_perso
Enter a secure passphrase when prompted (optional but recommended).
```
- For the second account (“pro” or “accountproName”):

```bash
ssh-keygen -t ed25519 -C “email@pro” -f ~/.ssh/id_ed25519_pro
```
- Add the public keys to GitHub:

Copy the public key: cat ~/.ssh/id_ed25519_perso.pub (paste it into GitHub > Settings > SSH and GPG keys > New SSH key for the corresponding account).

Repeat for the second key on the other account.

2. Configure the ~/.ssh/config file for aliases
Create or edit the ~/.ssh/config file to map each key to an alias (this redirects to github.com using the correct key).

Open the file:
```bash
vim ~/.ssh/config  # Or use your editor (e.g., VS Code)
chmod 600 ~/.ssh/config  # Secure permissions
```
- Add this content (adapt the names):
```bash
# perso (personal)
Host github-perso
    HostName github.com
    User git
    IdentityFile ~/.ssh/id_ed25519_perso
    IdentitiesOnly yes
```
```bash
# pro (professional)
Host github-pro
    HostName github.com
    User git
    IdentityFile ~/.ssh/id_ed25519_pro
    IdentitiesOnly yes
```
- Host: The alias you will use (github-account).
- IdentityFile: Path to the private key.
- IdentitiesOnly yes: Prevents other keys from being tried.

3. Add the keys to the SSH agent
This allows SSH to use the keys without asking for the passphrase each time.

```bash
eval “$(ssh-agent -s)”  # Start the agent if necessary
ssh-add ~/.ssh/id_ed25519_pro
ssh-add ~/.ssh/id_ed25519_perso
```
Check: 
```bash
ssh-add -l (lists the loaded keys).
```

4. Test the connections
```bash
ssh -T git@github-pro  # Should display “Hi [username_account]! You've successfully authenticated...”
ssh -T git@github-perso  # Same for the second account
```
If it works, no error – that's normal.

5. Configure Git remotes for your repositories
To clone a repo from perso:

```bash
git clone git@github-perso:username_perso/nom_repo.git
```
For an existing repo (your ~/terragrunt):

```bash
cd ~/terragrunt
git remote set-url origin git@github-perso:githubaccount/terragrunt.git
git remote -v  # Verify
```
- Repeat for the repositories in the second account using the alias “github-pro.”

6. Configure user information per repository (optional but recommended)
To ensure commits reflect the correct account:

```bash
cd path/to/repo_perso
git config user.name “accountPerso Name”
git config user.email “email@perso.com”
```
> **Repeat for the other repo. This is local to the repo and does not affect others.**

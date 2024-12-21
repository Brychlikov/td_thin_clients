## Nowy terminal
- zaloguj się

### w terminalu
```
sudo systemctl enable sshd
sudo systemctl restart sshd
sudo hostnamectl set-hostname terminalX
```

gotowe


### na macbooku
upewnij się, że jest odpowiedni rekord w `inventory.yaml`

```
ssh-copy-id user@<adres>
ansible-playbook -i inventory.yaml bootstrap.yaml --ask-become-pass
ansible-playbook -i inventory.yaml main.yaml
```


## Aktualizacje istniejących

generalnie uruchomienie powyższych komend `ansible...` też zadziała, ale szybciej będzie

```
ansible-playbook -i inventory.yaml monitor-trigger.yaml
```

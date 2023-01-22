# Como instalar o Terraform


## Instalar 
Esses passos é para instalar o terraform nos sistemas operacionais linux nas destribuições ubuntu/debian

**step 1:** Verifique se sua maquina está atualizada e isntalados os pacotes gnupg, software-properties-common e curl instalados

```
sudo apt-get update && sudo apt-get install -y gnupg software-properties-common
```

**step 2:** Instalar a HashiCorp GPG key.

``` 
    wget -O- https://apt.releases.hashicorp.com/gpg | \
    gpg --dearmor | \
    sudo tee /usr/share/keyrings/hashicorp-archive-keyring.gpg
```

**step 3:** Adicione o repositório oficial da HashiCorp ao seu sistema

```
echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] \
    https://apt.releases.hashicorp.com $(lsb_release -cs) main" | \
    sudo tee /etc/apt/sources.list.d/hashicorp.list
```

**step 4:** Dar update no sistema de pacotes do apt

```
sudo apt update
```

**step 5:** Instalar o terraform

```
sudo apt-get install terraform
```

## Mais informações

Caso vc esteja em outro sistema operacional veirifique o site oficial do [Terraform](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli)



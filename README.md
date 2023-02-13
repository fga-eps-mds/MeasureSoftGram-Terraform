# 2022-2-MeasureSoftGram-Terraform

Segue abaixo o link da Documentação do repositório

[Documentação](https://fga-eps-mds.github.io/2022-2-MeasureSoftGram-Terraform/#/)


## Pré-requisitos  para subir o ambiente

[Terraform](./documentation/Install-terraform.md)

[Docker](https://docs.docker.com/engine/install/ubuntu/)


## Subindo a Infra

**Atenção:** Verifique que todos os pré-requisitos foram resolvidos.

Depois de configura o ambiente da sua maquina ou do servidor execulte apenas os 2 comandos abaixo:

**Comandos:**


```terraform init``` (Esse comando é usado apenas na primeira vez)

```make init```

```make migrate```



## Url para acesso local
 
|Descrição | Urls |
|-----|----|
|Service |http://localhost/api/v1/|
|supported-metrics:| http://localhost/api/v1/supported-metrics/,
supported-measures: | http://localhost/api/v1/supported-measures/,
supported-subcharacteristics: | http://localhost/api/v1/supported-subcharacteristics/,
supported-characteristics: | http://localhost/api/v1/supported-characteristics/,
entity-relationship-tree:|  http://localhost/api/v1/entity-relationship-tree/,
organizations: | http://localhost/api/v1/organizations/

## Url para acesso em Cloud

Substitua o localhost pelo ip da maquina ou pelo dns da maquina


## Para criar o certificado https

Segue a [documentação](https://github.com/fga-eps-mds/2022-2-MeasureSoftGram-Terraform/blob/main/documentation/https.md) para adicionar o https no projeto em 4 passos.


**Atenção:** Lembre de adicionar o ip da maquina na plataforma responsavel pelo seu Dominio.



## **Duvidas recorrentes sobre o terraform**

**Como que faço para atualizar?** Execulte o comando make init.

**Não consigo rodar os scripts?** Verifique se você tem o make instalado na maquina e se você está na pasta raiz.

**Refazer a infra do zero?** Use o comando ```terrform destroy``` e repita os passos aenteriores. 


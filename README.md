# Acorte

## Desenvolvimento

### Ambiente

1. Duplique as variaveis de ambiente e as modifique

```
cp .env.example .env
```

2. Inicie o ambiente

```sh
docker-compose up -d
```

> `docker-compose down` para encerrar

3. Baixe as dependências

```sh
docker-compose exec app mix deps.get
```

3. Execute as *migrations*

```sh
docker-compose exec app mix ecto.migrate
```

4. Execute o *seeder*

```sh
docker-compose exec app mix run priv/repo/seeds.exs
```

> Durante o desenvolvimento `mix ecto.fresh` pode ser mais interessante

### Execução

1. Após o ambiente configurado, inicie o servidor em `localhost:4000`

```sh
docker-compose exec app mix phx.server
```

### Dicas

- `localhost:4000/dev/dashboard`
- `localhost:4007`
- `localhost:4000/dev/mailbox`

> `docker-compose exec app sh` acessa o container para executar comandos mais facilmente

#### Processo de debug

```sh
variavel |> dbg
variavel |> dbg(label: "blabla ====")
```

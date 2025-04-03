# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Acorte.Repo.insert!(%Acorte.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias Acorte.Repo
alias Acorte.Accounts.User
alias Acorte.Occasions.Occasion
alias Acorte.Polls.Poll
alias Acorte.Polls.PollOption
alias Acorte.Polls.Vote

users = [
  %{email: "admin@acorte.com", password: "123"},
  %{email: "rei@acorte.com", password: "123"},
  %{email: "neni@acorte.com", password: "123"},
  %{email: "vitor@acorte.com", password: "123"}
]

Enum.each(users, fn user ->
  %User{}
  |> User.changeset(user)
  |> Repo.insert!()
end)

# IDs dos usuários
rei = 2
neni = 3
vitor = 4

# title Encontro Presencial
# description primeiro encontro dos envolvidos
%Occasion{}
|> Occasion.changeset(%{
  title: "Encontro Presencial",
  description: "primeiro encontro dos envolvidos",
  owner_id: 3
})
|> Repo.insert!()

# poll para saber pizzas
%Poll{}
|> Poll.changeset(%{
  title: "Pizza",
  description: "Qual sabor de pizza você prefere?"
})
|> Repo.insert!()

# Defina o poll_id que será reutilizado
poll_id = 1

# Lista de sabores de pizza convertida de PHP para Elixir
pizza_options = [
  %{title: "Alho e óleo", description: "Mussarela e Alho e Óleo", poll_id: poll_id},
  %{title: "Americana", description: "Mussarela, Presunto e Palmito", poll_id: poll_id},
  %{title: "Atum", description: "Mussarela e Atum", poll_id: poll_id},
  %{title: "Bacon", description: "Mussarela e Bacon", poll_id: poll_id},
  %{title: "Bareza", description: "Mussarela, Calabresa, Cebola e Alho e Óleo", poll_id: poll_id},
  %{
    title: "Basca",
    description: "Mussarela, Calabresa, Bacon, Tomate e Catupiry",
    poll_id: poll_id
  },
  %{title: "Brócolis", description: "Mussarela e Brócolis com Catupiry", poll_id: poll_id},
  %{
    title: "Brócolis ao Molho Branco",
    description: "Mussarela e Brócolis ao Molho Branco",
    poll_id: poll_id
  },
  %{title: "Calabresa", description: "Mussarela e Calabresa", poll_id: poll_id},
  %{
    title: "Calabresa Forte",
    description: "Mussarela, Calabresa Forte e Cebola",
    poll_id: poll_id
  },
  %{title: "Carbonara", description: "Mussarela, Ovo, Catupiry e Bacon", poll_id: poll_id},
  %{title: "Carne de panela", description: "Mussarela e carne de panela", poll_id: poll_id},
  %{title: "Catuperu", description: "Mussarela e Peito de Peru", poll_id: poll_id},
  %{title: "Cebola na Manteiga", description: "Mussarela e Cebola na Manteiga", poll_id: poll_id},
  %{title: "Champignon", description: "Mussarela e Champignon", poll_id: poll_id},
  %{title: "Cheddar", description: "Mussarela, Bacon, Cebola e Cheddar", poll_id: poll_id},
  %{
    title: "Cinco Queijos",
    description: "Mussarela, Catupiry, Provolone, Parmesão e Cheddar",
    poll_id: poll_id
  },
  %{title: "Coração", description: "Mussarela e Coração", poll_id: poll_id},
  %{title: "Do Chefe", description: "Mussarela, Palmito, Champignon e Bacon", poll_id: poll_id},
  %{title: "Espanhola", description: "Mussarela, Pimentão, Bacon e Cebola", poll_id: poll_id},
  %{title: "Espinafre", description: "Mussarela e Espinafre com Molho Branco", poll_id: poll_id},
  %{title: "Frango", description: "Mussarela e Frango com Catupiry", poll_id: poll_id},
  %{
    title: "Frango a Xadrez",
    description: "Mussarela, Frango, Tomate, Pimentão e Cebola",
    poll_id: poll_id
  },
  %{title: "Fricassê", description: "Mussarela e Fricassê de Frango", poll_id: poll_id},
  %{title: "Gauchinha", description: "Mussarela, Iscas de Carne, Alho e Bacon", poll_id: poll_id},
  %{title: "Jardineira", description: "Mussarela, Palmito, Milho e Azeitona", poll_id: poll_id},
  %{
    title: "Lombo c/ Abacaxi",
    description: "Mussarela e Lombo Suíno com Abacaxi",
    poll_id: poll_id
  },
  %{title: "Lombo Canadense", description: "Mussarela e Lombo Canadense", poll_id: poll_id},
  %{
    title: "Mafiosa",
    description: "Mussarela, Beringela, Calabresa Forte, Azeitona e Parmesão",
    poll_id: poll_id
  },
  %{
    title: "Margarita",
    description: "Mussarela, Tomate, Manjericão, Azeitona e Parmesão",
    poll_id: poll_id
  },
  %{title: "Marioto", description: "Mussarela, Frango, Brócolis e Catupiry", poll_id: poll_id},
  %{title: "Milho", description: "Mussarela e Milho", poll_id: poll_id},
  %{title: "Milho c/ Bacon", description: "Mussarela e Milho com Bacon", poll_id: poll_id},
  %{title: "Mussarela", description: "Mussarela", poll_id: poll_id},
  %{title: "Napolitana", description: "Mussarela, Parmesão e Molho", poll_id: poll_id},
  %{title: "Palmito", description: "Mussarela e Palmito", poll_id: poll_id},
  %{
    title: "Portuguesa",
    description: "Mussarela, Presunto, Cebola, Ovo, Tomate, Pimentão e Azeitona",
    poll_id: poll_id
  },
  %{title: "Presunto", description: "Mussarela e Presunto", poll_id: poll_id},
  %{
    title: "Quatro Queijos",
    description: "Mussarela, Provolone, Parmesão e Catupiry",
    poll_id: poll_id
  },
  %{
    title: "Quatro Queijos c/ Bacon",
    description: "Mussarela, Provolone, Parmesão, Catupiry e Bacon",
    poll_id: poll_id
  },
  %{title: "Romana", description: "Mussarela, Presunto, Tomate e Parmesão", poll_id: poll_id},
  %{
    title: "Seis Queijos",
    description: "Mussarela, Catupiry, Provolone, Parmesão, Cheddar e Gorgonzola",
    poll_id: poll_id
  },
  %{title: "Siciliana", description: "Mussarela, Calabresa, Cebola e Azeitona", poll_id: poll_id},
  %{
    title: "Strogonoff",
    description: "Mussarela, Strogonoff de Carne e Champignon",
    poll_id: poll_id
  },
  %{
    title: "Suprema",
    description: "Mussarela, Presunto, Tomate, Pimentão, Champignon e Provolone",
    poll_id: poll_id
  },
  %{
    title: "Tarantela",
    description: "Mussarela, Cebola, Pimentão, Bacon, Parmesão e Azeitona",
    poll_id: poll_id
  },
  %{
    title: "Tomate Seco c/ Rucula",
    description: "Mussarela, Tomate seco e Rúcula",
    poll_id: poll_id
  },
  %{
    title: "Vegetariana",
    description: "Mussarela, Brócolis, Tomate, Palmito e Milho",
    poll_id: poll_id
  },
  %{
    title: "Zuquini",
    description: "Mussarela, Abobrinha, Champignon, Parmesão e Provolone",
    poll_id: poll_id
  }
]

# Insere os registros no banco de dados
Enum.each(pizza_options, fn pizza ->
  %PollOption{}
  |> PollOption.changeset(pizza)
  |> Repo.insert!()
end)

# Lista de votos
votes = [
  %{poll_option_id: 6, is_favorite: false, user_id: rei},
  %{poll_option_id: 9, is_favorite: false, user_id: rei},
  %{poll_option_id: 12, is_favorite: false, user_id: rei},
  %{poll_option_id: 13, is_favorite: false, user_id: rei},
  %{poll_option_id: 18, is_favorite: false, user_id: rei},
  %{poll_option_id: 24, is_favorite: false, user_id: rei},
  %{poll_option_id: 25, is_favorite: false, user_id: rei},
  %{poll_option_id: 27, is_favorite: true, user_id: rei},
  %{poll_option_id: 28, is_favorite: false, user_id: rei},
  %{poll_option_id: 32, is_favorite: false, user_id: rei},
  %{poll_option_id: 33, is_favorite: false, user_id: rei},
  %{poll_option_id: 44, is_favorite: false, user_id: rei},
  %{poll_option_id: 45, is_favorite: false, user_id: rei},
  %{poll_option_id: 6, is_favorite: false, user_id: neni},
  %{poll_option_id: 9, is_favorite: false, user_id: neni},
  %{poll_option_id: 11, is_favorite: false, user_id: neni},
  %{poll_option_id: 13, is_favorite: true, user_id: neni},
  %{poll_option_id: 17, is_favorite: false, user_id: neni},
  %{poll_option_id: 18, is_favorite: false, user_id: neni},
  %{poll_option_id: 22, is_favorite: false, user_id: neni},
  %{poll_option_id: 25, is_favorite: false, user_id: neni},
  %{poll_option_id: 27, is_favorite: false, user_id: neni},
  %{poll_option_id: 28, is_favorite: false, user_id: neni},
  %{poll_option_id: 33, is_favorite: false, user_id: neni},
  %{poll_option_id: 39, is_favorite: false, user_id: neni},
  %{poll_option_id: 40, is_favorite: false, user_id: neni},
  %{poll_option_id: 42, is_favorite: false, user_id: neni},
  %{poll_option_id: 44, is_favorite: false, user_id: neni},
  %{poll_option_id: 1, is_favorite: false, user_id: vitor},
  %{poll_option_id: 9, is_favorite: false, user_id: vitor},
  %{poll_option_id: 12, is_favorite: false, user_id: vitor},
  %{poll_option_id: 16, is_favorite: false, user_id: vitor},
  %{poll_option_id: 17, is_favorite: false, user_id: vitor},
  %{poll_option_id: 24, is_favorite: false, user_id: vitor},
  %{poll_option_id: 25, is_favorite: false, user_id: vitor},
  %{poll_option_id: 39, is_favorite: false, user_id: vitor},
  %{poll_option_id: 40, is_favorite: true, user_id: vitor},
  %{poll_option_id: 42, is_favorite: false, user_id: vitor},
  %{poll_option_id: 44, is_favorite: false, user_id: vitor}
]

# Insere os votos no banco de dados
Enum.each(votes, fn vote ->
  %Vote{}
  |> Vote.changeset(vote)
  |> Repo.insert!()
end)

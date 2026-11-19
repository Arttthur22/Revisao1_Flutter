# Revisão 1

Nome: _(preencha)_
Turma: _(preencha)_

> Os resultados abaixo foram deduzidos da implementação. Execute o app no Chrome e confirme cada linha antes de entregar.

| Teste | Resultado esperado | Resultado encontrado |
|---|---|---|
| Nome vazio/espaços | Mensagem de erro; nada é salvo | Validador `textoObrigatorio` recusa e exibe mensagem no campo |
| Quantidade negativa | Mensagem de erro | `quantidade` recusa ("-3" não é só dígitos) |
| Quantidade decimal | Mensagem de erro | `quantidade` recusa ("2.5" / "2,5") |
| Nome repetido com maiúsculas/espaços | Recusado: "Já existe um material com esse nome." | `existeNome` compara `trim().toLowerCase()` com `nome_normalizado`; " microfone " é recusado |
| Edição mantendo o próprio nome | Salva normalmente | `existeNome` ignora o próprio ID (`id <> ?`) |
| Edição para o nome de outro material | Recusada | `existeNome` encontra o outro registro e a ViewModel lança erro |
| Cadastro com atualização automática | Item aparece na lista sem recarregar | `inserir` grava e a ViewModel chama `carregar()` + `notifyListeners()` |
| Edição persistida após recarregar | Alteração permanece | `atualizar` usa `WHERE id = ?` e grava no SQLite |
| Cancelamento da exclusão | Registro permanece | Diálogo retorna `false`; `excluir` não é chamado |
| Exclusão individual | Só o selecionado some | `excluir` usa `WHERE id = ?` |
| Quantidade zero e mínimo zero | "Sem estoque" | `situacao` testa `quantidade == 0` primeiro |
| Quantidade igual ao mínimo | "Estoque adequado" | `quantidade >= minimo` cai no último caso |

Também: 0 → Sem estoque; 1 com mínimo 3 → Estoque baixo.

## Explique uma validação

**Qual validação foi escolhida?**
Quantidade aceita somente inteiros maiores ou iguais a zero (rejeita vazio, letras, negativos e decimais).

**Em qual arquivo e método ela foi implementada?**
`lib/utils/validadores.dart`, método `Validadores.quantidade`.

**Por que esse local é adequado para essa responsabilidade?**
A regra é pura (recebe texto, devolve mensagem ou `null`) e não depende de interface nem de banco. Por isso fica em uma classe utilitária reutilizável: o `TextFormField` usa o método para exibir o erro ao usuário, e a `MaterialViewModel.salvar` o chama de novo para proteger a operação mesmo se for chamada fora da tela. A regra fica em um único lugar, fácil de testar e de alterar.

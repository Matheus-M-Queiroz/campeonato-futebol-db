# Banco de Dados — Campeonato de Futebol

Banco MySQL/MariaDB modelado a partir do DER com as entidades
**CAMPEONATO**, **TIME**, **JOGADOR**, **FAMILIAR**, **JOGO** e
**DESEMPENHO_JOGADOR** (relacionamento N:N entre JOGADOR e JOGO).

## Estrutura

```
sql/schema.sql    -> cria o banco futebol_db e as 6 tabelas
sql/dados.sql     -> popula com 2 campeonatos, 5 times, 15 jogadores,
                     15 familiares, 10 jogos e os desempenhos dos jogadores
sql/consultas.sql -> as 11 consultas pedidas
```

## Modelo

- `campeonato (1) --- INCLUI --- (N) time`
- `campeonato (1) --- ORGANIZA --- (N) jogo`
- `time (1) --- POSSUI --- (N) jogador`
- `time (1) --- MANDANTE/VISITANTE --- (N) jogo` (duas FKs em `jogo`:
  `id_time_mandante` e `id_time_visitante`)
- `jogador (1) --- POSSUI_FAMILIAR --- (N) familiar`
- `jogador (N) --- ATUA_EM --- (N) jogo`, resolvido pela tabela
  associativa `desempenho_jogador` (gols, assistências, cartões,
  minutos jogados em cada jogo)

## Como rodar (Laragon)

```powershell
mysql -u root < sql/schema.sql
mysql -u root < sql/dados.sql
```

### Conferir as tabelas criadas (prints pedidos)

```powershell
mysql -u root futebol_db -e "SHOW TABLES;"
mysql -u root futebol_db -e "DESC campeonato; DESC time; DESC jogador; DESC familiar; DESC jogo; DESC desempenho_jogador;"
```

Ou, dentro do prompt interativo (`mysql -u root futebol_db`):
```sql
SHOW TABLES;
DESC campeonato;
DESC time;
DESC jogador;
DESC familiar;
DESC jogo;
DESC desempenho_jogador;
```

### Rodar as 11 consultas

```powershell
mysql -u root futebol_db < sql/consultas.sql
```

Ou copie cada consulta do `sql/consultas.sql` e cole uma de cada vez no
prompt do `mysql`, pra tirar um print por questão.

## Dados de exemplo

- **5 times**: Palmeiras, Corinthians (SP), Flamengo (RJ), Grêmio (RS),
  Atlético Mineiro (MG) — 3 jogadores cada (15 no total), cada um com
  1 familiar cadastrado.
- **10 jogos**: todos os confrontos entre os 5 times (turno único),
  incluindo empates, um jogo com mais de 3 gols do mandante (Palmeiras
  4x0 Grêmio) e um jogo no estádio "RioBrancao" (Corinthians 2x2
  Flamengo).
- **Classificação esperada** (consulta 11): Palmeiras (8 pts), Flamengo
  (6 pts, melhor saldo/gols pró que o Atlético-MG), Atlético Mineiro
  (6 pts), Corinthians (4 pts), Grêmio (1 pt).

Os resultados das consultas foram conferidos previamente simulando o
mesmo schema e dados em SQLite, com checagem automática de que a soma
dos gols em `desempenho_jogador` bate com `gols_mandante`/
`gols_visitante` de cada jogo em `jogo`.

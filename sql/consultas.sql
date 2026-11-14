-- Consultas sobre o banco futebol_db
-- Rode primeiro: mysql -u root < sql/schema.sql
--                mysql -u root < sql/dados.sql

USE futebol_db;

-- 1. Dados de todas as tabelas
SELECT * FROM campeonato;
SELECT * FROM time;
SELECT * FROM jogador;
SELECT * FROM familiar;
SELECT * FROM jogo;
SELECT * FROM desempenho_jogador;

-- 2. Jogadores por time
SELECT t.nome AS time, j.nome AS jogador, j.posicao, j.numero_camisa
FROM time t
JOIN jogador j ON j.id_time = t.id_time
ORDER BY t.nome, j.nome;

-- 3. Quantidade de jogadores por time
SELECT t.nome AS time, COUNT(j.id_jogador) AS qtd_jogadores
FROM time t
LEFT JOIN jogador j ON j.id_time = t.id_time
GROUP BY t.id_time, t.nome
ORDER BY t.nome;

-- 4. Times do estado de SP
SELECT * FROM time WHERE estado = 'SP';

-- 5. Jogadores nascidos antes de 2006
SELECT nome, data_nascimento FROM jogador
WHERE data_nascimento < '2006-01-01'
ORDER BY data_nascimento;

-- 6. Jogos que terminaram empatados
SELECT j.id_jogo, tm.nome AS mandante, j.gols_mandante, j.gols_visitante, tv.nome AS visitante, j.data_jogo
FROM jogo j
JOIN time tm ON tm.id_time = j.id_time_mandante
JOIN time tv ON tv.id_time = j.id_time_visitante
WHERE j.gols_mandante = j.gols_visitante;

-- 7. Todos os campeonatos
SELECT * FROM campeonato;

-- 8. Todos os jogos e seus resultados
SELECT j.id_jogo, tm.nome AS mandante, j.gols_mandante, j.gols_visitante, tv.nome AS visitante, j.data_jogo, j.estadio
FROM jogo j
JOIN time tm ON tm.id_time = j.id_time_mandante
JOIN time tv ON tv.id_time = j.id_time_visitante
ORDER BY j.data_jogo;

-- 9. Jogos com mais de 3 gols do mandante
SELECT j.id_jogo, tm.nome AS mandante, j.gols_mandante, j.gols_visitante, tv.nome AS visitante
FROM jogo j
JOIN time tm ON tm.id_time = j.id_time_mandante
JOIN time tv ON tv.id_time = j.id_time_visitante
WHERE j.gols_mandante > 3;

-- 10. Jogos realizados no estadio "RioBrancao"
SELECT j.id_jogo, tm.nome AS mandante, j.gols_mandante, j.gols_visitante, tv.nome AS visitante, j.data_jogo
FROM jogo j
JOIN time tm ON tm.id_time = j.id_time_mandante
JOIN time tv ON tv.id_time = j.id_time_visitante
WHERE j.estadio = 'RioBrancao';

-- 11. (BONUS) Classificacao geral do campeonato
SELECT
    t.nome AS time,
    COUNT(*) AS jogos,
    SUM(CASE WHEN r.gols_pro > r.gols_contra THEN 1 ELSE 0 END) AS vitorias,
    SUM(CASE WHEN r.gols_pro = r.gols_contra THEN 1 ELSE 0 END) AS empates,
    SUM(CASE WHEN r.gols_pro < r.gols_contra THEN 1 ELSE 0 END) AS derrotas,
    SUM(r.gols_pro) AS gols_pro,
    SUM(r.gols_contra) AS gols_contra,
    SUM(r.gols_pro) - SUM(r.gols_contra) AS saldo_gols,
    SUM(CASE
            WHEN r.gols_pro > r.gols_contra THEN 3
            WHEN r.gols_pro = r.gols_contra THEN 1
            ELSE 0
        END) AS pontos
FROM (
    SELECT id_time_mandante AS id_time, gols_mandante AS gols_pro, gols_visitante AS gols_contra FROM jogo
    UNION ALL
    SELECT id_time_visitante AS id_time, gols_visitante AS gols_pro, gols_mandante AS gols_contra FROM jogo
) r
JOIN time t ON t.id_time = r.id_time
GROUP BY t.id_time, t.nome
ORDER BY pontos DESC, saldo_gols DESC, gols_pro DESC;

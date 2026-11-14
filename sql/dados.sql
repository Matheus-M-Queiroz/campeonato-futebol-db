-- Dados de exemplo: 5 times, 15 jogadores (3 por time), 15 familiares, 10 jogos e desempenhos
-- Rode primeiro: mysql -u root < sql/schema.sql

USE futebol_db;

-- Campeonatos
INSERT INTO campeonato (id_campeonato, nome, ano, data_inicio, data_fim) VALUES
(1, 'Campeonato Brasileiro Serie A', 2024, '2024-04-01', '2024-12-08'),
(2, 'Copa Regional', 2025, '2025-02-01', NULL);

-- Times (todos disputando o campeonato 1)
INSERT INTO time (id_time, nome, cidade, estado, tecnico, id_campeonato) VALUES
(1, 'Palmeiras', 'Sao Paulo', 'SP', 'Abel Ferreira', 1),
(2, 'Corinthians', 'Sao Paulo', 'SP', 'Ramon Diaz', 1),
(3, 'Flamengo', 'Rio de Janeiro', 'RJ', 'Tite', 1),
(4, 'Gremio', 'Porto Alegre', 'RS', 'Renato Portaluppi', 1),
(5, 'Atletico Mineiro', 'Belo Horizonte', 'MG', 'Gabriel Milito', 1);

-- Jogadores (3 por time)
INSERT INTO jogador (id_jogador, nome, data_nascimento, posicao, nacionalidade, numero_camisa, id_time) VALUES
(1,  'Endrick',          '2006-07-14', 'Atacante',   'Brasil',    9, 1),
(2,  'Gustavo Gomez',    '1993-03-06', 'Zagueiro',   'Paraguai', 15, 1),
(3,  'Raphael Veiga',    '1995-06-19', 'Meia',       'Brasil',   23, 1),
(4,  'Yuri Alberto',     '2001-02-18', 'Atacante',   'Brasil',    9, 2),
(5,  'Fagner',           '1989-06-11', 'Lateral',    'Brasil',   23, 2),
(6,  'Gustavo Henrique', '1993-02-21', 'Zagueiro',   'Brasil',    4, 2),
(7,  'Pedro',            '1997-06-20', 'Atacante',   'Brasil',    9, 3),
(8,  'Gerson',           '1997-05-20', 'Meia',       'Brasil',    8, 3),
(9,  'Everton Ribeiro',  '1989-04-10', 'Meia',       'Brasil',    7, 3),
(10, 'Diego Costa',      '1988-10-07', 'Atacante',   'Brasil',   19, 4),
(11, 'Villasanti',       '1998-05-16', 'Meia',       'Paraguai',  5, 4),
(12, 'Kannemann',        '1991-07-14', 'Zagueiro',   'Argentina', 4, 4),
(13, 'Hulk',              '1986-07-25', 'Atacante',  'Brasil',    7, 5),
(14, 'Paulinho',         '2000-07-15', 'Atacante',   'Brasil',    9, 5),
(15, 'Everson',          '1995-08-15', 'Goleiro',    'Brasil',    1, 5);

-- Familiares (1 por jogador)
INSERT INTO familiar (nome, grau_parentesco, telefone, observacoes, id_jogador) VALUES
('Maria Silva',      'Mae',     '11999990001', NULL, 1),
('Carlos Gomez',     'Pai',     '11999990002', NULL, 2),
('Camila Veiga',     'Conjuge', '11999990003', NULL, 3),
('Ana Alberto',      'Mae',     '11999990004', NULL, 4),
('Jose Fagner',      'Pai',     '11999990005', NULL, 5),
('Lucas Henrique',   'Irmao',   '11999990006', NULL, 6),
('Beatriz Pedro',    'Mae',     '21999990007', NULL, 7),
('Marcos Gerson',    'Pai',     '21999990008', NULL, 8),
('Juliana Ribeiro',  'Conjuge', '21999990009', NULL, 9),
('Rosa Costa',       'Mae',     '51999990010', NULL, 10),
('Pedro Villasanti', 'Pai',     '51999990011', NULL, 11),
('Sofia Kannemann',  'Irma',    '51999990012', NULL, 12),
('Camila Hulk',      'Conjuge', '31999990013', NULL, 13),
('Tereza Paulinho',  'Mae',     '31999990014', NULL, 14),
('Antonio Everson',  'Pai',     '31999990015', NULL, 15);

-- Jogos (10 = todos os confrontos entre os 5 times, campeonato 1)
INSERT INTO jogo (id_jogo, data_jogo, estadio, gols_mandante, gols_visitante, id_campeonato, id_time_mandante, id_time_visitante) VALUES
(1,  '2024-04-06', 'Allianz Parque',       2, 1, 1, 1, 2),
(2,  '2024-04-13', 'Allianz Parque',       3, 3, 1, 1, 3),
(3,  '2024-04-20', 'Allianz Parque',       4, 0, 1, 1, 4),
(4,  '2024-04-27', 'Allianz Parque',       1, 1, 1, 1, 5),
(5,  '2024-05-04', 'RioBrancao',           2, 2, 1, 2, 3),
(6,  '2024-05-11', 'Neo Quimica Arena',    1, 0, 1, 2, 4),
(7,  '2024-05-18', 'Neo Quimica Arena',    0, 2, 1, 2, 5),
(8,  '2024-05-25', 'Maracana',             3, 1, 1, 3, 4),
(9,  '2024-06-01', 'Maracana',             2, 2, 1, 3, 5),
(10, '2024-06-08', 'Arena do Gremio',      1, 1, 1, 4, 5);

-- Desempenho dos jogadores (artilheiros e alguns cartoes de cada jogo)
INSERT INTO desempenho_jogador (gols, assistencias, cartoes_amarelos, cartoes_vermelhos, minutos_jogados, id_jogador, id_jogo) VALUES
-- Jogo 1: Palmeiras 2 x 1 Corinthians
(2, 0, 0, 0, 90, 1, 1),   -- Endrick
(0, 1, 0, 0, 90, 3, 1),   -- Veiga (assistencia)
(1, 0, 0, 0, 90, 4, 1),   -- Yuri Alberto
-- Jogo 2: Palmeiras 3 x 3 Flamengo
(1, 0, 0, 0, 90, 1, 2),   -- Endrick
(2, 0, 0, 0, 90, 3, 2),   -- Veiga
(2, 0, 0, 0, 90, 7, 2),   -- Pedro
(1, 0, 1, 0, 90, 8, 2),   -- Gerson (amarelo)
-- Jogo 3: Palmeiras 4 x 0 Gremio
(3, 0, 0, 0, 90, 1, 3),   -- Endrick
(1, 0, 0, 0, 90, 3, 3),   -- Veiga
(0, 0, 1, 0, 90, 12, 3),  -- Kannemann (amarelo)
-- Jogo 4: Palmeiras 1 x 1 Atletico-MG
(1, 0, 0, 0, 90, 3, 4),   -- Veiga
(1, 0, 0, 0, 90, 13, 4),  -- Hulk
(0, 0, 0, 0, 90, 15, 4),  -- Everson
-- Jogo 5: Corinthians 2 x 2 Flamengo (RioBrancao)
(2, 0, 0, 0, 90, 4, 5),   -- Yuri Alberto
(1, 0, 0, 0, 90, 7, 5),   -- Pedro
(1, 1, 0, 0, 90, 9, 5),   -- Everton Ribeiro
-- Jogo 6: Corinthians 1 x 0 Gremio
(1, 0, 0, 0, 90, 4, 6),   -- Yuri Alberto
(0, 0, 0, 1, 75, 6, 6),   -- Gustavo Henrique (vermelho)
-- Jogo 7: Corinthians 0 x 2 Atletico-MG
(1, 0, 0, 0, 90, 13, 7),  -- Hulk
(1, 0, 0, 0, 90, 14, 7),  -- Paulinho
(0, 0, 0, 0, 90, 15, 7),  -- Everson
-- Jogo 8: Flamengo 3 x 1 Gremio
(2, 0, 0, 0, 90, 7, 8),   -- Pedro
(1, 1, 0, 0, 90, 8, 8),   -- Gerson
(1, 0, 0, 0, 90, 10, 8),  -- Diego Costa
-- Jogo 9: Flamengo 2 x 2 Atletico-MG
(1, 0, 0, 0, 90, 7, 9),   -- Pedro
(1, 0, 0, 0, 90, 9, 9),   -- Everton Ribeiro
(1, 0, 0, 0, 90, 13, 9),  -- Hulk
(1, 0, 0, 0, 90, 14, 9),  -- Paulinho
-- Jogo 10: Gremio 1 x 1 Atletico-MG
(1, 0, 0, 0, 90, 10, 10), -- Diego Costa
(1, 0, 0, 0, 90, 14, 10), -- Paulinho
(0, 0, 0, 0, 90, 15, 10); -- Everson

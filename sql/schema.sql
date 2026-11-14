-- Banco de dados de Campeonato de Futebol
-- Modelado a partir do DER: CAMPEONATO, TIME, JOGADOR, FAMILIAR, JOGO, DESEMPENHO_JOGADOR

CREATE DATABASE IF NOT EXISTS futebol_db
    CHARACTER SET utf8mb4
    COLLATE utf8mb4_unicode_ci;

USE futebol_db;

-- CAMPEONATO (1) --- INCLUI --- (N) TIME
-- CAMPEONATO (1) --- ORGANIZA --- (N) JOGO
CREATE TABLE campeonato (
    id_campeonato INT AUTO_INCREMENT PRIMARY KEY,
    nome          VARCHAR(100) NOT NULL,
    ano           INT NOT NULL,
    data_inicio   DATE,
    data_fim      DATE
);

-- TIME (1) --- POSSUI --- (N) JOGADOR
-- TIME (1) --- MANDANTE/VISITANTE --- (N) JOGO
CREATE TABLE time (
    id_time       INT AUTO_INCREMENT PRIMARY KEY,
    nome          VARCHAR(100) NOT NULL,
    cidade        VARCHAR(100),
    estado        CHAR(2),
    tecnico       VARCHAR(100),
    id_campeonato INT NOT NULL,
    FOREIGN KEY (id_campeonato) REFERENCES campeonato(id_campeonato)
);

CREATE TABLE jogador (
    id_jogador      INT AUTO_INCREMENT PRIMARY KEY,
    nome            VARCHAR(100) NOT NULL,
    data_nascimento DATE,
    posicao         VARCHAR(50),
    nacionalidade   VARCHAR(50),
    numero_camisa   INT,
    id_time         INT NOT NULL,
    FOREIGN KEY (id_time) REFERENCES time(id_time)
);

-- JOGADOR (1) --- POSSUI_FAMILIAR --- (N) FAMILIAR
CREATE TABLE familiar (
    id_familiar     INT AUTO_INCREMENT PRIMARY KEY,
    nome            VARCHAR(100) NOT NULL,
    grau_parentesco VARCHAR(50),
    telefone        VARCHAR(20),
    observacoes     VARCHAR(255),
    id_jogador      INT NOT NULL,
    FOREIGN KEY (id_jogador) REFERENCES jogador(id_jogador)
);

CREATE TABLE jogo (
    id_jogo           INT AUTO_INCREMENT PRIMARY KEY,
    data_jogo         DATE NOT NULL,
    estadio           VARCHAR(100),
    gols_mandante     INT DEFAULT 0,
    gols_visitante    INT DEFAULT 0,
    id_campeonato     INT NOT NULL,
    id_time_mandante  INT NOT NULL,
    id_time_visitante INT NOT NULL,
    FOREIGN KEY (id_campeonato) REFERENCES campeonato(id_campeonato),
    FOREIGN KEY (id_time_mandante) REFERENCES time(id_time),
    FOREIGN KEY (id_time_visitante) REFERENCES time(id_time)
);

-- JOGADOR (N) --- ATUA_EM --- (N) JOGO, resolvida por DESEMPENHO_JOGADOR
CREATE TABLE desempenho_jogador (
    id_desempenho     INT AUTO_INCREMENT PRIMARY KEY,
    gols              INT DEFAULT 0,
    assistencias      INT DEFAULT 0,
    cartoes_amarelos  INT DEFAULT 0,
    cartoes_vermelhos INT DEFAULT 0,
    minutos_jogados   INT DEFAULT 0,
    id_jogador        INT NOT NULL,
    id_jogo           INT NOT NULL,
    FOREIGN KEY (id_jogador) REFERENCES jogador(id_jogador),
    FOREIGN KEY (id_jogo) REFERENCES jogo(id_jogo)
);

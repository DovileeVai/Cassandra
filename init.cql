CREATE KEYSPACE IF NOT EXISTS chat_app WITH REPLICATION = {
    'class': 'SimpleStrategy', 'replication_factor': 1
};

USE chat_app;

-- Lentele kanalo duomenims saugoti
CREATE TABLE IF NOT EXISTS chat_app.channels
(
    id TEXT,
    owner TEXT,
    topic TEXT,
    PRIMARY KEY (id)
);

-- Lentele nariams kanaluose saugoti
CREATE TABLE IF NOT EXISTS chat_app.members 
(
    id TEXT,
    channel_id TEXT,
    member TEXT,
    PRIMARY KEY ((channel_id), member)
);

-- Lentele kanalu pranesimu paieskai pagal channel_id ir timestamp
CREATE TABLE IF NOT EXISTS chat_app.messages_by_channel (
    id TEXT,
    channel_id TEXT,
    text TEXT,
    author TEXT,
    timestamp BIGINT,
    PRIMARY KEY ((channel_id), timestamp, id)
) WITH CLUSTERING ORDER BY (timestamp ASC);

CREATE INDEX IF NOT EXISTS ON messages_by_channel(author);
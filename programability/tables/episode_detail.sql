CREATE TABLE episode_detail
(
     season_id int not null
    ,episode_id int not null
    ,filter_id int not null

    ,primary key(season_id, episode_id, filter_id)
    ,foreign key(season_id) REFERENCES episode(season) ON UPDATE CASCADE ON DELETE CASCADE
    ,foreign key(episode_id) REFERENCES episode(episode) ON UPDATE CASCADE ON DELETE CASCADE
    ,foreign key(filter_id) REFERENCES filter(id) ON UPDATE CASCADE ON DELETE CASCADE
);
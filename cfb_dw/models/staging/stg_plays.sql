{{
  config(
    materialized = 'view',
    )
}}

with plays as (
    select * from {{ source('staging', 'plays') }}

    union

    select * from {{ source('staging', 'plays_2018') }}

    union

    select * from {{ source('staging', 'plays_2019') }}

    union

    select * from {{ source('staging', 'plays_2020') }}

    union

    select * from {{ source('staging', 'plays_2021') }}

    union

    select * from {{ source('staging', 'plays_2022') }}

    union 

    select * from {{ source('staging', 'plays_2023') }}
)

select 
    id,
    drive_id,
    game_id,
    drive_number,
    play_number,
    offense,
    offense_conference,
    offense_score,
    defense,
    defense_conference,
    defense_score,
    home,
    away,
    period,
    clock.minutes * 60 + clock.seconds as period_seconds_remaining,
    offense_timeouts,
    defense_timeouts,
    yard_line,
    yards_to_goal,
    down,
    distance,
    yards_gained,
    scoring,
    play_type,
    case 
        when play_type in ('Rush','Rushing Touchdown') then 1
        else 0
    end as is_rush,
    case
        when play_type in ('Pass','Sack','Pass Interception Return','Pass Reception','Interception','Interception Return Touchdown','Pass Incompletion','Passing Touchdown') then 1
        else 0
    end as is_pass,
    case
        when play_type in ('Field Goal Missed','Missed Field Goal Return','Missed Field Goal Return Touchdown','Blocked Field Goal','Field Goal Good','Blocked Field Goal Touchdown') then 1
        else 0
    end as is_fg,
    case
        when play_type in ('Blocked Punt','Punt','Punt Return Touchdown','Blocked Punt Touchdown') then 1
        else 0
    end as is_punt,
    case
        when play_type in ('Kickoff','Kickoff Return Touchdown','Kickoff Return (Offense)') then 1
        else 0
    end as is_kickoff,
    ppa
from plays
SELECT
    user_pseudo_id,
    category,
    country,
    subscription_start,
    subscription_end,
    `Week Starts`,
    `Week ENDS`,
    Week,
    `Purchase date`,
    `Purchase amount`,
    Currency
FROM
    `tc-da-1.AI_data.clv`
QUALIFY ROW_NUMBER() OVER (
    PARTITION BY CAST(user_pseudo_id AS STRING)
    ORDER BY
        CAST(category IS NOT NULL AS INT64) +
        CAST(country IS NOT NULL AS INT64) +
        CAST(subscription_start IS NOT NULL AS INT64) +
        CAST(subscription_end IS NOT NULL AS INT64) +
        CAST(`Week Starts` IS NOT NULL AS INT64) +
        CAST(`Week ENDS` IS NOT NULL AS INT64) +
        CAST(Week IS NOT NULL AS INT64) +
        CAST(`Purchase date` IS NOT NULL AS INT64) +
        CAST(`Purchase amount` IS NOT NULL AS INT64) +
        CAST(Currency IS NOT NULL AS INT64) DESC,
        `Purchase date` DESC
) = 1
ORDER BY
    `Purchase date` DESC,
    user_pseudo_id;
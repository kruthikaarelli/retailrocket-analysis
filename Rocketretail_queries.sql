
-- Overall funnel

SELECT
    COUNT(DISTINCT CASE WHEN event = 'view' THEN visitorid END) AS visitors_who_viewed,
    COUNT(DISTINCT CASE WHEN event = 'addtocart' THEN visitorid END) AS visitors_who_carted,
    COUNT(DISTINCT CASE WHEN event = 'transaction' THEN visitorid END) AS visitors_who_purchased,
    ROUND(COUNT(DISTINCT CASE WHEN event = 'addtocart' THEN visitorid END) * 100.0 /
          COUNT(DISTINCT CASE WHEN event = 'view' THEN visitorid END), 1) AS view_to_cart_pct,
    ROUND(COUNT(DISTINCT CASE WHEN event = 'transaction' THEN visitorid END) * 100.0 /
          COUNT(DISTINCT CASE WHEN event = 'addtocart' THEN visitorid END), 1) AS cart_to_purchase_pct,
    ROUND(COUNT(DISTINCT CASE WHEN event = 'transaction' THEN visitorid END) * 100.0 /
          COUNT(DISTINCT CASE WHEN event = 'view' THEN visitorid END), 1) AS overall_conversion_pct
FROM events


-- QUERY 2 Event type breakdown

SELECT
    event,
    COUNT(*) AS total_events,
    COUNT(DISTINCT visitorid) AS unique_visitors,
    ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER(), 1) AS share_pct
FROM events
GROUP BY event
ORDER BY total_events DESC

--  QUERY 3 Top 10 most viewed items

SELECT
    itemid,
    COUNT(CASE WHEN event = 'view' THEN 1 END) AS views,
    COUNT(CASE WHEN event = 'addtocart' THEN 1 END) AS add_to_carts,
    COUNT(CASE WHEN event = 'transaction' THEN 1 END) AS purchases,
    ROUND(COUNT(CASE WHEN event = 'addtocart' THEN 1 END) * 100.0 /
          NULLIF(COUNT(CASE WHEN event = 'view' THEN 1 END), 0), 1) AS view_to_cart_pct
FROM events
GROUP BY itemid
ORDER BY views DESC
LIMIT 10

-- QUERY 4 Visitor behavior segmentation

SELECT
    CASE
        WHEN purchased = 1 THEN 'Converted (Purchased)'
        WHEN carted = 1    THEN 'Cart Abandoner'
        ELSE 'Viewer Only'
    END AS visitor_segment,
    COUNT(*) AS visitors,
    ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER(), 1) AS pct_of_visitors
FROM (
    SELECT
        visitorid,
        MAX(CASE WHEN event = 'addtocart'   THEN 1 ELSE 0 END) AS carted,
        MAX(CASE WHEN event = 'transaction' THEN 1 ELSE 0 END) AS purchased
    FROM events
    GROUP BY visitorid
) visitor_summary
GROUP BY visitor_segment
ORDER BY visitors DESC

-- QUERY 5  Hourly activity pattern
SELECT
    FLOOR(timestamp / 3600000) % 24 AS hour_of_day,
    COUNT(CASE WHEN event = 'view' THEN 1 END) AS views,
    COUNT(CASE WHEN event = 'addtocart' THEN 1 END) AS add_to_carts,
    COUNT(CASE WHEN event = 'transaction' THEN 1 END) AS purchases
FROM events
GROUP BY hour_of_day
ORDER BY hour_of_day

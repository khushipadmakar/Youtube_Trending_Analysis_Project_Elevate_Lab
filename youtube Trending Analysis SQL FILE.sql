CREATE DATABASE youtube_trending;
USE youtube_trending;
SELECT * FROM invideos2;

-- 1. Count total number of videos in the dataset --
SELECT COUNT(*) AS total_videos FROM invideos2;

-- 2. Count videos by category --
SELECT category_id, COUNT(*) AS video_count 
FROM invideos2 
GROUP BY category_id 
ORDER BY video_count DESC;

-- 3. Get the top 10 most liked videos
SELECT video_id, channel_title, likes 
FROM invideos2 
ORDER BY likes DESC 
LIMIT 10;

-- 4. Top 10 channels with most trending videos
SELECT channel_title, COUNT(*) AS trending_videos 
FROM invideos2 
GROUP BY channel_title 
ORDER BY trending_videos DESC 
LIMIT 10;

-- 5. Channels with highest average views per video (minimum 5 videos)
SELECT channel_title, COUNT(*) AS video_count, AVG(views) AS avg_views
FROM invideos2
GROUP BY channel_title
HAVING video_count >= 5
ORDER BY avg_views DESC
LIMIT 10;

-- 6. Videos with highest like-to-dislike ratio (minimum 1000 likes)
SELECT video_id, channel_title, 
       likes/dislikes AS like_dislike_ratio
FROM invideos2
WHERE dislikes > 0 AND likes >= 1000
ORDER BY like_dislike_ratio DESC
LIMIT 10;

-- 7. Videos with most comments relative to views
SELECT video_id, channel_title, 
       comment_count/views AS comments_per_view
FROM invideos2
WHERE views > 100000
ORDER BY comments_per_view DESC
LIMIT 10;

-- 8. Videos published by hour of day
SELECT HOUR(publish_time) AS publish_hour,
       COUNT(*) AS video_count,
       AVG(views) AS avg_views
FROM invideos2
GROUP BY publish_hour
ORDER BY publish_hour;

-- 9. Performance by days since publish to trending
SELECT DATEDIFF(trending_date, DATE(publish_time)) AS days_to_trend,
       AVG(views) AS avg_views,
       AVG(likes) AS avg_likes
FROM invideos2
GROUP BY days_to_trend
ORDER BY days_to_trend;

-- 10. Percentage of videos with comments disabled
SELECT 
    (SUM(CASE WHEN comments_disabled = TRUE THEN 1 ELSE 0 END) / COUNT(*)) * 100 AS pct_comments_disabled
FROM invideos2;

-- 11. Percentage of videos with ratings disabled
SELECT 
    (SUM(CASE WHEN ratings_disabled = TRUE THEN 1 ELSE 0 END) / COUNT(*)) * 100 AS pct_ratings_disabled
FROM invideos2;

-- 12. Videos that were removed or had errors
SELECT COUNT(*) AS error_or_removed_videos
FROM invideos2
WHERE video_error_or_removed = TRUE;

-- 13. Category Popularity by Average Views -- 
SELECT 
    category_id,
    COUNT(*) AS video_count,
    AVG(views) AS avg_views,
    ROUND(AVG(likes), 0) AS avg_likes,
    ROUND(AVG(dislikes), 0) AS avg_dislikes
FROM invideos2
GROUP BY category_id
ORDER BY avg_views DESC;

-- 14. Most Successful Channels-- 
SELECT 
    channel_title,
    COUNT(*) AS trending_videos,
    SUM(views) AS total_views,
    ROUND(SUM(likes)/SUM(views)*100, 2) AS like_percentage
FROM invideos2
GROUP BY channel_title
ORDER BY total_views DESC
LIMIT 10;


-- 15. Time Series Analysis -- 
SELECT 
    trending_date,
    COUNT(*) AS videos_trending,
    AVG(views) AS avg_views,
    AVG(TIMESTAMPDIFF(HOUR, publish_time, trending_date)) AS hours_to_trend
FROM invideos2
GROUP BY trending_date
ORDER BY trending_date;

-- 15. Engagement Analysis-- 
SELECT 
    CASE 
        WHEN likes/dislikes > 20 THEN 'Highly Positive'
        WHEN likes/dislikes > 10 THEN 'Positive'
        WHEN likes/dislikes > 5 THEN 'Neutral'
        ELSE 'Negative'
    END AS sentiment,
    COUNT(*) AS video_count,
    AVG(views) AS avg_views,
    AVG(comment_count) AS avg_comments
FROM invideos2
WHERE dislikes > 0
GROUP BY sentiment;
use ig_clone;

/*1.Finding 5 oldest users*/
SELECT * 
FROM users
ORDER BY created_at
LIMIT 5;

/*2.Users with no photos*/
SELECT users.id as user_id,username
FROM users
LEFT JOIN photos
    ON users.id = photos.user_id
WHERE photos.id IS NULL;

/*3.Most liked photo and its user*/
SELECT 
    username,
    photos.id,
    photos.image_url, 
    COUNT(*) AS total_likes
FROM photos
INNER JOIN likes
    ON likes.photo_id = photos.id
INNER JOIN users
    ON photos.user_id = users.id
GROUP BY photos.id
ORDER BY total_likes DESC
LIMIT 1;

/*4.Most used hasthtags*/
SELECT tags.tag_name, 
       Count(*) AS total_tags 
FROM   photo_tags 
       JOIN tags 
         ON photo_tags.tag_id = tags.id 
GROUP  BY tags.id 
ORDER  BY total_tags DESC 
LIMIT  5; 

/*5.Popular registration date*/
SELECT 
    DAYNAME(created_at) AS day,
    COUNT(*) AS total_regs
FROM users
GROUP BY day
ORDER BY total_regs DESC
LIMIT 3;

/*6.AVG user photos/total photos/total users*/
SELECT 
(SELECT Count(*) FROM   photos) / 
(SELECT Count(*) FROM   users) 
AS avg; 
                          
/*7.Users who liked every single photos*/
SELECT username, 
       Count(*) AS num_likes 
FROM   users 
       INNER JOIN likes 
               ON users.id = likes.user_id 
GROUP  BY likes.user_id 
HAVING num_likes = (SELECT Count(*) 
                    FROM   photos); 
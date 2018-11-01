docker build -t m0rgulnet/post:1.0 ./post-py
docker build -t m0rgulnet/comment:1.0 ./comment
docker build -t m0rgulnet/ui:1.0 ./ui
docker network create reddit
docker run -d --network=reddit --network-alias=reddit_post_db --network-alias=reddit_comment_db -v reddit_db:/data/db mongo:latest
docker run -d --network=reddit --network-alias=reddit_post --env POST_DATABASE_HOST=reddit_post_db m0rgulnet/post:1.0
docker run -d --network=reddit --network-alias=reddit_comment --env COMMENT_DATABASE_HOST=reddit_comment_db m0rgulnet/comment:1.0
docker run -d --network=reddit -p 9292:9292 --env POST_SERVICE_HOST=reddit_post --env COMMENT_SERVICE_HOST=reddit_comment m0rgulnet/ui:2.0

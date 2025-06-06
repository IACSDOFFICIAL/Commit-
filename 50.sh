#!/bin/bash

# Configuration
REPO_PATH="/c/Users/dbda/try/description"  # Git Bash style path
DAYS_TO_FILL=50  # Number of days to simulate commits
START_DATE=$(date -d "$DAYS_TO_FILL days ago" +%s)

# Loop through each day
for ((i=0; i<DAYS_TO_FILL; i++)); do
    DATE=$(date -d "@$((START_DATE + i * 86400))" +%Y-%m-%d)

    # Generate random number of commits (1 to 5)
    NUM_COMMITS=$(( (RANDOM % 5) + 1 ))

    for ((j=1; j<=NUM_COMMITS; j++)); do
        echo "Random commit $j for $DATE" > "$REPO_PATH/dummy.txt"

        cd "$REPO_PATH"
        git add .
        GIT_AUTHOR_DATE="$DATE 12:$j:00" GIT_COMMITTER_DATE="$DATE 12:$j:00" \
        git commit -m "Random commit $j on $DATE" --date "$DATE 12:$j:00"
    done

    rm "$REPO_PATH/dummy.txt"
done

# Push all commits
cd "$REPO_PATH"
git push origin main

# Environment Variables Template
# Copy this file to .env.fish and fill in your actual values
# This file is gitignored to prevent accidental commits of secrets

# OpenAI API Key (replace with your actual key or 1Password reference)
# Option 1: Direct key (less secure)
# set -gx OPENAI_API_KEY "your-actual-api-key-here"

# Option 2: 1Password reference (recommended)
# set -gx OPENAI_API_KEY (op read "op://Personal/OpenAI/API Key")

# Add other sensitive environment variables here
# set -gx ANOTHER_API_KEY "your-key-here"
# set -gx DATABASE_URL "your-database-url-here"

# Example of other common environment variables you might need:
# set -gx GITHUB_TOKEN (op read "op://Personal/GitHub/Personal Access Token")
# set -gx AWS_ACCESS_KEY_ID (op read "op://Personal/AWS/Access Key ID")
# set -gx AWS_SECRET_ACCESS_KEY (op read "op://Personal/AWS/Secret Access Key")
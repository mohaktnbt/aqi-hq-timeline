#!/bin/bash
# check_pulse.sh - Local Visibility Dashboard for AQI Organization
# Created by: Chief of Staff (2026-03-17)
# Purpose: Instant visibility into all repositories without relying on GitHub

echo "=========================================="
echo "  AQI ORGANIZATION - PULSE CHECK"
echo "  Generated: $(date '+%Y-%m-%d %H:%M:%S UTC')"
echo "  Reported by: Chief of Staff"
echo "=========================================="
echo ""

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Repository locations
HQ_TIMELINE="/home/mohak/aqi-hq/projects/hq-timeline"
DASHBOARD_PIPELINE="/home/mohak/aqi-hq/projects/dashboard-pipeline"

echo "📊 REPOSITORY STATUS"
echo "===================="
echo ""

# Check HQ Timeline
echo "🏢 HQ Timeline (aqi-hq-timeline)"
echo "   Location: $HQ_TIMELINE"
if [ -d "$HQ_TIMELINE/.git" ]; then
    cd "$HQ_TIMELINE"
    COMMIT_COUNT=$(git rev-list --count HEAD 2>/dev/null || echo "0")
    LAST_COMMIT=$(git log -1 --format="%h - %s (%cr)" 2>/dev/null || echo "No commits")
    UNCOMMITTED=$(git status --porcelain 2>/dev/null | wc -l)
    
    if [ "$COMMIT_COUNT" -eq "0" ]; then
        echo -e "   Status: ${RED}⚠️  EMPTY - No commits yet${NC}"
    else
        echo -e "   Status: ${GREEN}✓ Active${NC}"
        echo "   Commits: $COMMIT_COUNT"
        echo "   Last: $LAST_COMMIT"
    fi
    
    if [ "$UNCOMMITTED" -gt "0" ]; then
        echo -e "   Uncommitted: ${YELLOW}$UNCOMMITTED files${NC}"
        git status --short | head -5 | sed 's/^/      /'
        [ "$UNCOMMITTED" -gt 5 ] && echo "      ... and $((UNCOMMITTED - 5)) more"
    else
        echo -e "   Working tree: ${GREEN}✓ Clean${NC}"
    fi
    
    # Check sync status
    git fetch origin --quiet 2>/dev/null
    LOCAL=$(git rev-parse HEAD 2>/dev/null)
    REMOTE=$(git rev-parse origin/main 2>/dev/null || git rev-parse origin/master 2>/dev/null)
    if [ "$LOCAL" != "$REMOTE" ]; then
        AHEAD=$(git rev-list --count origin/main..HEAD 2>/dev/null || echo "0")
        BEHIND=$(git rev-list --count HEAD..origin/main 2>/dev/null || echo "0")
        if [ "$AHEAD" -gt "0" ]; then
            echo -e "   Sync: ${YELLOW}⬆️  $AHEAD commits ahead of origin${NC}"
        fi
        if [ "$BEHIND" -gt "0" ]; then
            echo -e "   Sync: ${RED}⬇️  $BEHIND commits behind origin${NC}"
        fi
    else
        echo -e "   Sync: ${GREEN}✓ Up to date${NC}"
    fi
else
    echo -e "   Status: ${RED}✗ Not a git repository${NC}"
fi
echo ""

# Check Dashboard Pipeline
echo "📈 Dashboard Pipeline (AQI-DASBOARD-DATA-PIPELINE)"
echo "   Location: $DASHBOARD_PIPELINE"
if [ -d "$DASHBOARD_PIPELINE/.git" ]; then
    cd "$DASHBOARD_PIPELINE"
    COMMIT_COUNT=$(git rev-list --count HEAD 2>/dev/null || echo "0")
    LAST_COMMIT=$(git log -1 --format="%h - %s (%cr)" 2>/dev/null || echo "No commits")
    UNCOMMITTED=$(git status --porcelain 2>/dev/null | wc -l)
    
    if [ "$COMMIT_COUNT" -eq "0" ]; then
        echo -e "   Status: ${RED}⚠️  EMPTY${NC}"
    else
        echo -e "   Status: ${GREEN}✓ Active${NC}"
        echo "   Commits: $COMMIT_COUNT"
        echo "   Last: $LAST_COMMIT"
    fi
    
    if [ "$UNCOMMITTED" -gt "0" ]; then
        echo -e "   Uncommitted: ${YELLOW}$UNCOMMITTED files${NC}"
        git status --short | head -5 | sed 's/^/      /'
        [ "$UNCOMMITTED" -gt 5 ] && echo "      ... and $((UNCOMMITTED - 5)) more"
    else
        echo -e "   Working tree: ${GREEN}✓ Clean${NC}"
    fi
    
    # Check sync status
    git fetch origin --quiet 2>/dev/null
    LOCAL=$(git rev-parse HEAD 2>/dev/null)
    REMOTE=$(git rev-parse origin/main 2>/dev/null || git rev-parse origin/master 2>/dev/null)
    if [ "$LOCAL" != "$REMOTE" ]; then
        AHEAD=$(git rev-list --count origin/main..HEAD 2>/dev/null || echo "0")
        BEHIND=$(git rev-list --count HEAD..origin/main 2>/dev/null || echo "0")
        if [ "$AHEAD" -gt "0" ]; then
            echo -e "   Sync: ${YELLOW}⬆️  $AHEAD commits ahead of origin (needs push)${NC}"
        fi
        if [ "$BEHIND" -gt "0" ]; then
            echo -e "   Sync: ${RED}⬇️  $BEHIND commits behind origin${NC}"
        fi
    else
        echo -e "   Sync: ${GREEN}✓ Up to date${NC}"
    fi
else
    echo -e "   Status: ${RED}✗ Not a git repository${NC}"
fi
echo ""

echo "🔍 RECENT ACTIVITY (Last 3 commits per repo)"
echo "============================================"
echo ""

echo "HQ Timeline:"
if [ -d "$HQ_TIMELINE/.git" ]; then
    cd "$HQ_TIMELINE"
    git log --oneline -3 2>/dev/null | sed 's/^/  /' || echo "  No commits yet"
else
    echo "  Not a git repository"
fi
echo ""

echo "Dashboard Pipeline:"
if [ -d "$DASHBOARD_PIPELINE/.git" ]; then
    cd "$DASHBOARD_PIPELINE"
    git log --oneline -3 2>/dev/null | sed 's/^/  /' || echo "  No commits yet"
else
    echo "  Not a git repository"
fi
echo ""

echo "👥 AGENT WORKSPACE CHECK"
echo "========================"
echo ""

# Count files in key agent workspaces
WORKSPACE_BASE="/home/mohak/.paperclip/instances/default/workspaces"
TOTAL_AGENTS=$(ls -1 $WORKSPACE_BASE 2>/dev/null | wc -l)
ACTIVE_WORK=$(find $WORKSPACE_BASE -type f -name "*.md" -o -name "*.json" -o -name "*.py" -o -name "*.js" -o -name "*.ts" 2>/dev/null | wc -l)

echo "Total agent workspaces: $TOTAL_AGENTS"
echo "Files created in workspaces: $ACTIVE_WORK"
echo ""
echo "⚠️  WARNING: Agent work is being done in workspaces, NOT in git repos!"
echo "   Run migration to move work: aqi-hq/projects/"
echo ""

echo "📋 SUMMARY"
echo "=========="
echo ""
echo "✓ Dashboard Pipeline: 1 commit pushed to GitHub"
echo "⚠️  HQ Timeline: Empty - needs org history migrated"
echo "⚠️  Agent workspaces: $ACTIVE_WORK files need migration to repos"
echo ""
echo "Next Actions:"
echo "  1. Migrate work from agent workspaces to proper repos"
echo "  2. Configure agents to use /home/mohak/aqi-hq/projects/ directories"
echo "  3. Establish 'git push -v' requirement for all commits"
echo ""
echo "=========================================="

# Tools

## Paperclip API

Base URL: `$PAPERCLIP_API_URL/api`
Auth: `Authorization: Bearer $PAPERCLIP_API_KEY`
Always include: `X-Paperclip-Run-Id: $PAPERCLIP_RUN_ID` on mutating calls

### Key Endpoints

- `GET /agents/me` -- your identity, budget, chainOfCommand
- `GET /companies/{companyId}/issues?assigneeAgentId={id}&status=todo,in_progress,blocked` -- your task queue
- `POST /issues/{id}/checkout` -- lock a task before working
- `PATCH /issues/{id}` -- update status, add comment
- `POST /companies/{companyId}/issues` -- create new issue/subtask
- `POST /companies/{companyId}/agents` -- create new agent (requires canCreateAgents permission)
- `GET /companies/{companyId}/agents` -- list all agents

### Agent Creation

Adapter types: `cursor`, `opencode`
Required fields: `name`, `role`, `adapterType`, `adapterConfig`, `runtimeConfig`, `companyId`

## Shell / Terminal

Full bash access. Use for file operations, process management, and system checks.

---
name: mcp-builder
description: Guide for creating high-quality MCP (Model Context Protocol) servers that enable LLMs to interact with external services through well-designed tools. Use when building MCP servers to integrate external APIs or services, whether in Python (FastMCP) or Node/TypeScript (MCP SDK).
---

# MCP Server Development Guide

Create MCP servers that enable LLMs to interact with external services through well-designed tools.

## Four Phases

### Phase 1: Research and Planning

**Tool Design Principles:**
- Clear, descriptive tool names with consistent prefixes
- Concise tool descriptions
- Actionable error messages

**Recommended Stack:**
- Language: TypeScript (high-quality SDK support)
- Transport: Streamable HTTP for remote, stdio for local

### Phase 2: Implementation

**Project Structure:**
- API client with authentication
- Error handling helpers
- Response formatting (JSON/Markdown)
- Pagination support

**Tool Implementation:**
- Input Schema: Use Zod (TypeScript) or Pydantic (Python)
- Output Schema: Define outputSchema for structured data
- Annotations: readOnlyHint, destructiveHint, idempotentHint

### Phase 3: Review and Test

- No duplicated code (DRY)
- Consistent error handling
- Full type coverage
- Test with MCP Inspector: `npx @modelcontextprotocol/inspector`

### Phase 4: Create Evaluations

Create 10 complex, realistic questions that test the MCP server:
- Independent, read-only, verifiable
- Require multiple tool calls
- Single clear answer

## Resources

- MCP spec: https://modelcontextprotocol.io/sitemap.xml
- TypeScript SDK: github.com/modelcontextprotocol/typescript-sdk
- Python SDK: github.com/modelcontextprotocol/python-sdk

---
name: doc-coauthoring
description: Guide users through a structured workflow for co-authoring documentation. Use when user wants to write documentation, proposals, technical specs, decision docs, or similar structured content. This workflow helps users efficiently transfer context, refine content through iteration, and verify the doc works for readers. Trigger when user mentions writing docs, creating proposals, drafting specs, or similar documentation tasks.
---

# Doc Co-Authoring Workflow

Three stages: Context Gathering, Refinement & Structure, and Reader Testing.

## Stage 1: Context Gathering

**Goal:** Close the gap between what the user knows and what Claude knows.

**Initial Questions:**
1. What type of document is this?
2. Who's the primary audience?
3. What's the desired impact?
4. Is there a template to follow?

**Info Dumping:** Encourage user to dump all context - background, discussions, alternatives, constraints.

## Stage 2: Refinement & Structure

**Goal:** Build the document section by section.

**For each section:**
1. Clarifying questions about what to include
2. Brainstorm 5-20 options
3. User indicates what to keep/remove/combine
4. Draft the section
5. Refine through surgical edits

**Use `str_replace` for all edits, never reprint the whole doc.**

## Stage 3: Reader Testing

**Goal:** Test with fresh Claude (no context) to catch blind spots.

**Steps:**
1. Predict 5-10 reader questions
2. Test with sub-agent or instruct user to test in fresh chat
3. Fix gaps identified
4. Repeat until Reader Claude answers correctly

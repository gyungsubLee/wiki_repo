# KN Wiki

## Reference

- [karpathy/442a6bf555914893e9891c11519de94f](https://gist.github.com/karpathy/442a6bf555914893e9891c11519de94f)
- [karpathy/status/2015883857489522876](https://x.com/karpathy/status/2015883857489522876)
- [multica-ai/andrej-karpathy-skills/skills/karpathy-guidelines/SKILL.md](https://github.com/multica-ai/andrej-karpathy-skills/blob/main/skills/karpathy-guidelines/SKILL.md)

### 언어 문서

- [한국어](README.md)
- [English](README.en.md)

## 프로젝트 의도

이 저장소는 범용 챗봇이나 단순 RAG가 아니라, 시간이 지날수록 지식이 누적되는 개인 LLM 시스템을 만드는 실험입니다. 질문할 때마다 문서를 다시 조립하는 대신, LLM이 Git 기반 Markdown wiki를 계속 갱신해 나갑니다. 사용자는 원본 자료와 방향을 제공하고, LLM은 요약, 링크, 정리, 유지보수를 맡습니다.

## 핵심 구조

이 저장소는 세 계층으로 구성됩니다.

1. **Raw sources**: `wiki/raw/`에 보관되는 원본 자료입니다. 기사, 회의록, 로그, PR 설명, 문서처럼 출처가 되는 자료이며 LLM이 임의로 수정하지 않는 source of truth입니다.
2. **Wiki**: `wiki/wiki/`, `wiki/decisions/`, `wiki/projects/`, `wiki/troubleshooting/` 등에 저장되는 LLM 생성 지식 계층입니다. 요약, 개념 페이지, 결정 기록, 문제 해결 기록, 프로젝트 맥락이 서로 연결됩니다.
3. **Schema**: `AGENTS.md`, `CLAUDE.md`, `CONTEXT.md`, runbook, template이 여기에 해당합니다. LLM이 어떤 구조와 규칙으로 ingest, query, lint, 유지보수를 해야 하는지 정의합니다.

운영 방식은 네 가지 흐름으로 정리합니다.

- `/ingest`: 새 원본 자료를 읽고 wiki 페이지, 결정 기록, 프로젝트 맥락에 통합합니다.
- `/query`: 원본을 매번 다시 뒤지는 대신, 이미 정리된 wiki를 먼저 읽고 근거 있는 답변을 만듭니다.
- `/tag`: 노트의 태그, 관계, frontmatter, 링크를 정리합니다.
- `/lint`: 오래된 주장, 모순, 고립된 페이지, 빠진 링크, 추가로 조사할 질문을 점검합니다.

Codex는 코드 작업자, Hermes는 운영 에이전트, Git은 지식 변경의 이력과 협업 기반입니다. Obsidian은 사람이 읽고 탐색하는 IDE입니다.

결과적으로 이 저장소는 채팅 기록을 보관하는 곳이 아니라, 질문과 작업을 거칠수록 더 정교해지는 지식 시스템입니다.

## 어떻게 쓰나

1. 원본 자료를 `wiki/raw/`에 넣습니다.
2. `wiki/wiki/`, `wiki/decisions/`, `wiki/projects/`, `wiki/troubleshooting/`로 정리합니다.
3. 코드 작업 전 Codex가 `AGENTS.md`와 `CONTEXT.md`, `wiki/wiki/index.md`를 읽습니다.
4. 작업 후 변경 사항과 검증 결과를 다시 wiki에 적습니다.
5. Hermes가 `wiki/hermes/`와 `wiki/reports/`를 통해 반복 점검을 수행합니다.
6. `scripts/wiki-health-check.sh`로 구조를 점검하고 Git에 커밋합니다.

## 디렉터리 구조

```text
.
├── AGENTS.md
├── CLAUDE.md
├── CONTEXT.md
├── README.md
├── README.en.md
├── docs/
│   ├── adr/
│   ├── runbooks/
│   └── workflows/
├── scripts/
└── wiki/
    ├── inbox/
    ├── raw/
    ├── wiki/
    ├── decisions/
    ├── projects/
    ├── meetings/
    ├── troubleshooting/
    ├── prompts/
    ├── templates/
    ├── reports/
    └── hermes/
        ├── tasks/
        ├── runs/
        └── schedules/
```

## 디렉터리

| 경로 | 목적 |
| --- | --- |
| `wiki/inbox/` | 분류 전 임시 수집 |
| `wiki/raw/` | 최소한만 편집한 원본 자료 |
| `wiki/wiki/` | 오래 쓸 개념 노트와 인덱스 |
| `wiki/decisions/` | ADR 스타일 결정과 tradeoff |
| `wiki/projects/` | 활성 프로젝트 맥락, 상태, 링크 |
| `wiki/meetings/` | 회의록과 액션 아이템 |
| `wiki/troubleshooting/` | 버그, 장애, 수정, 교훈 |
| `wiki/prompts/` | Codex와 Hermes 재사용 프롬프트 |
| `wiki/templates/` | 노트 템플릿 |
| `wiki/reports/` | 사람이 읽을 lint, review, automation 결과 리포트 |
| `wiki/hermes/` | Hermes 작업 정의, 실행 로그, 스케줄 메모 |
| `docs/adr/` | 저장소 구조와 workflow 관련 결정 기록 |
| `docs/` | runbook과 workflow 문서 |

## 시작하기

이 폴더를 Obsidian 볼트로 엽니다.

```bash
open -a Obsidian /Users/igyeongseob/Develop/kn_wiki
```

저장소 상태를 확인합니다.

```bash
cd /Users/igyeongseob/Develop/kn_wiki
./scripts/wiki-health-check.sh
git status --short
```

## 작업 흐름

```bash
Read /Users/igyeongseob/Develop/kn_wiki/AGENTS.md and CONTEXT.md.
Search this wiki for decisions, troubleshooting notes, and project context related to:

<작업 주제>

Before editing code, summarize:
1. relevant constraints
2. prior decisions
3. known risks
4. verification commands to run
```

코드 작업이 끝나면 결과를 다시 wiki에 반영합니다.

```text
Read the latest git diff and verification output from the code repository.
Update /Users/igyeongseob/Develop/kn_wiki with the root cause, decision, changed files summary, and verification evidence.
Use the relevant template under wiki/templates/.
```

`wiki/wiki/index.md`를 시작점으로 사용하고, 새 노트는 `wiki/templates/`를 참고해서 작성합니다.

## Codex

Codex는 코드 변경 전후로 wiki를 읽고 갱신하는 역할을 맡습니다. 반복해서 쓸 프롬프트는 `wiki/prompts/codex.md`에 정리되어 있습니다.

## Hermes

Hermes는 반복 점검과 리포트 생성을 맡습니다. 주된 작업은 다음과 같습니다.

- 매일 wiki 상태 점검
- 최근 Git 변경사항 요약
- 오래된 노트 점검
- 누락된 태그와 링크 점검
- 프로젝트별 진행 상황 리포트 생성

반복해서 쓸 Hermes 프롬프트는 `wiki/prompts/hermes.md`에 정리되어 있습니다. Hermes 작업 정의, 실행 요약, 스케줄 메모는 `wiki/hermes/` 아래에 둡니다.

## Git

변경 후에는 검증하고 diff를 확인합니다.

```bash
cd /Users/igyeongseob/Develop/kn_wiki
./scripts/wiki-health-check.sh
git status --short
git diff --stat
```

커밋 예시:

```bash
git add -- .
git commit -m "docs: capture auth troubleshooting"
```

원격 동기화가 필요할 때만 push합니다.

```bash
git push origin main
```

## 자주 보는 문서

- Main wiki index: `wiki/wiki/index.md`
- Codex runbook: `docs/runbooks/codex-workflow.md`
- Hermes runbook: `docs/runbooks/hermes-workflow.md`
- Git workflow: `docs/runbooks/git-workflow.md`
- End-to-end scenario: `docs/workflows/llm-wiki-codex-hermes-git.md`

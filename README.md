# KN Wiki

## Reference

- [karpathy/442a6bf555914893e9891c11519de94f](https://gist.github.com/karpathy/442a6bf555914893e9891c11519de94f)
- [karpathy/status/2015883857489522876](https://x.com/karpathy/status/2015883857489522876)
- [multica-ai/andrej-karpathy-skills/skills/karpathy-guidelines/SKILL.md](https://github.com/multica-ai/andrej-karpathy-skills/blob/main/skills/karpathy-guidelines/SKILL.md)

### 언어 문서

- [한국어](README.md)
- [English](README.en.md)

KN Wiki는 LLM Wiki + Codex + Hermes 워크플로우를 위한 Git 기반 Obsidian 볼트입니다.

이 저장소는 하나의 반복 루프를 위해 설계되었습니다.

1. 이슈, 회의, 로그, 아티클, 코드 변경에서 원본 맥락을 수집합니다.
2. 원본을 오래 쓸 수 있는 wiki 노트로 정리합니다.
3. 코드 작업 전에 Codex가 wiki를 조회합니다.
4. Hermes가 반복 점검, lint, 요약 작업을 실행합니다.
5. 의미 있는 지식 변경을 Git으로 커밋합니다.

## 프로젝트 의도

이 프로젝트의 목적은 범용 챗봇이나 단순 RAG 저장소가 아니라, 시간이 지날수록 지식이 누적되는 개인 LLM 시스템을 만드는 것입니다.

일반적인 챗봇과 파일 업로드 기반 RAG는 질문할 때마다 원본 문서 조각을 다시 찾고 다시 조합합니다. 답변은 얻을 수 있지만, 그 과정에서 만들어진 요약, 연결, 모순 발견, 판단 근거는 대화가 끝나면 사라지기 쉽습니다. 같은 주제를 다시 묻는 순간 LLM은 비슷한 탐색을 반복해야 하고, 지식은 자산으로 축적되지 않습니다.

KN Wiki는 이 문제를 Git 기반 Markdown wiki로 해결하려는 프로젝트입니다. 사용자는 원본 자료를 선별하고 질문과 방향을 제시합니다. LLM은 자료를 읽고, 요약하고, 관련 페이지를 갱신하고, 링크를 만들고, 모순과 빈틈을 표시하고, 유지보수 작업을 수행합니다. Obsidian은 사람이 지식을 탐색하는 IDE이고, LLM은 wiki를 수정하는 프로그래머이며, wiki는 계속 진화하는 코드베이스처럼 다룹니다.

이 저장소는 세 계층으로 구성됩니다.

1. **Raw sources**: `wiki/raw/`에 보관되는 원본 자료입니다. 기사, 회의록, 로그, PR 설명, 문서처럼 출처가 되는 자료이며 LLM이 임의로 수정하지 않는 source of truth입니다.
2. **Wiki**: `wiki/wiki/`, `wiki/decisions/`, `wiki/projects/`, `wiki/troubleshooting/` 등에 저장되는 LLM 생성 지식 계층입니다. 요약, 개념 페이지, 결정 기록, 문제 해결 기록, 프로젝트 맥락이 서로 연결됩니다.
3. **Schema**: `AGENTS.md`, `CLAUDE.md`, `CONTEXT.md`, runbook, template이 여기에 해당합니다. LLM이 어떤 구조와 규칙으로 ingest, query, lint, 유지보수를 해야 하는지 정의합니다.

운영 방식은 네 가지 명령형 흐름으로 정리합니다.

- `/ingest`: 새 원본 자료를 읽고 wiki 페이지, 결정 기록, 프로젝트 맥락에 통합합니다.
- `/query`: 원본을 매번 다시 뒤지는 대신, 이미 정리된 wiki를 먼저 읽고 근거 있는 답변을 만듭니다.
- `/tag`: 노트의 태그, 관계, frontmatter, 링크를 정리합니다.
- `/lint`: 오래된 주장, 모순, 고립된 페이지, 빠진 링크, 추가로 조사할 질문을 점검합니다.

Codex는 코드 작업자가 됩니다. 코드 변경 전에 wiki를 조회하고, 작업 후 diff, 테스트 결과, 결정 이유를 다시 wiki에 기록합니다. Hermes는 운영 에이전트가 됩니다. 반복 점검, 최근 변경 요약, 오래된 노트 검토, 리포트 생성을 맡습니다. Git은 이 모든 지식 변경의 이력과 협업 기반이 됩니다.

결과적으로 이 저장소는 채팅 기록을 보관하는 곳이 아니라, 질문과 작업을 거칠수록 더 정교해지는 지식 시스템입니다. LLM이 반복적인 정리와 연결 작업을 맡고, 사람은 좋은 자료를 고르고 좋은 질문을 던지는 데 집중합니다.

## 디렉터리 구조

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

## 첫 실행

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

## 사용 가이드

이 저장소는 단순한 메모 폴더가 아닙니다. LLM 에이전트가 반복해서 읽고 갱신하고 재사용할 수 있는 장기 프로젝트 기억 저장소입니다. 핵심 루프는 다음과 같습니다.

```text
원본 자료 수집
-> 구조화된 노트로 정리
-> 코드 작업 전 wiki 조회
-> 검증 후 결과를 다시 기록
-> Git으로 지식 변경 이력 저장
```

## 1. Obsidian으로 사용하기

볼트를 엽니다.

```bash
open -a Obsidian /Users/igyeongseob/Develop/kn_wiki
```

`wiki/wiki/index.md`를 첫 화면처럼 사용합니다. 출처가 있는 자료는 바로 `wiki/wiki/`에 넣기보다 `wiki/raw/`에 먼저 저장한 뒤, 오래 쓸 지식만 구조화된 노트로 승격하는 방식을 권장합니다.

## 2. 자료 수집하기

새로운 자료는 성격에 따라 아래 위치에 둡니다.

| 상황 | 위치 | 예시 |
| --- | --- | --- |
| 아직 정리 전인 임시 메모 | `wiki/inbox/` | 빠른 아이디어, 처리 전 링크 |
| 원본 자료 | `wiki/raw/` | 회의 전문, 이슈 본문, PR 설명, 로그 |
| 정리된 개념 | `wiki/wiki/` | 인증 설계, 배포 전략, API 규칙 |
| 의사결정 | `wiki/decisions/` | 기술 선택, 아키텍처 결정 |
| 프로젝트 상태 | `wiki/projects/` | 목표, 현재 진행률, 다음 액션 |
| 회의록 | `wiki/meetings/` | 회의 내용, 결정, 액션 아이템 |
| 버그와 해결 기록 | `wiki/troubleshooting/` | 증상, 원인, 수정, 검증 |

새 노트를 만들 때는 `wiki/templates/`의 템플릿을 사용합니다.

## 3. Codex와 함께 쓰기

코드 작업 전에 Codex에게 이 wiki를 먼저 읽게 합니다.

```text
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

반복해서 쓸 Codex 프롬프트는 `wiki/prompts/codex.md`에 정리되어 있습니다.

## 4. Hermes와 함께 쓰기

Hermes는 사람이 매번 기억하기 어려운 반복 점검에 사용합니다.

예시:

```bash
cd /Users/igyeongseob/Develop/kn_wiki
hermes -p "Read AGENTS.md and CONTEXT.md. Run scripts/wiki-health-check.sh. Review git status. Write a dated report in wiki/reports/. Do not push."
```

권장 반복 작업:

- 매일 wiki 상태 점검
- 최근 Git 변경사항 요약
- 오래된 노트 점검
- 누락된 태그와 링크 점검
- 프로젝트별 진행 상황 리포트 생성

반복해서 쓸 Hermes 프롬프트는 `wiki/prompts/hermes.md`에 정리되어 있습니다. Hermes 작업 정의, 실행 요약, 스케줄 메모는 `wiki/hermes/` 아래에 둡니다.

## 5. Git으로 관리하기

wiki 변경 후에는 검증하고 diff를 확인합니다.

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

원격 동기화가 명시적으로 필요할 때만 push합니다.

```bash
git push origin main
```

## 6. 추천 하루 운영 루프

```text
1. 회의, 이슈, PR, 로그를 wiki/raw/에 저장
2. 중요한 내용은 wiki/wiki/, wiki/decisions/, wiki/troubleshooting/으로 정리
3. 코드 작업 전 Codex가 wiki를 조회
4. 코드 작업 후 diff, 테스트 결과, 결정사항을 wiki에 반영
5. Hermes가 wiki/reports/에 유지보수 리포트 생성
6. scripts/wiki-health-check.sh 실행
7. Git commit으로 지식 변경 이력 저장
```

## 7. 좋은 노트 기준

좋은 wiki 노트는 다음 질문에 답합니다.

- 무엇이 사실인가?
- 왜 중요한가?
- 다음 에이전트나 개발자가 무엇을 조심해야 하는가?
- 관련 결정이나 장애 기록은 어디에 있는가?
- 어떤 명령이나 테스트로 확인했는가?

채팅 기록은 작업 기억에서 빠르게 사라집니다. 다시 쓸 가치가 있는 내용은 이 저장소에 노트로 남깁니다.

## 먼저 볼 문서

- Main wiki index: `wiki/wiki/index.md`
- Codex runbook: `docs/runbooks/codex-workflow.md`
- Hermes runbook: `docs/runbooks/hermes-workflow.md`
- Git workflow: `docs/runbooks/git-workflow.md`
- End-to-end scenario: `docs/workflows/llm-wiki-codex-hermes-git.md`

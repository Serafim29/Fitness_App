# Fitness App

Fitness App este o aplicație mobilă realizată cu Flutter, pornind de la macheta disponibilă în [Figma](https://www.figma.com/design/3HeBH74VC2MHhKwXGnqI2e/Laboratoare-2026?node-id=3-411&p=f&t=qRO5SipDTqsUipis-0). Aplicația prezintă programe de antrenament, planuri recomandate și informații despre săli de fitness.

## Date și arhitectură

Aplicația folosește endpointurile fitness v3:

- `GET /lab2026/v3/feed` pentru challenge, planuri și programe;
- `GET /lab2026/v3/feed/details` pentru detaliile sălii.

Fluxul datelor este: ecranul (Presentation) → `Lab3Cubit` → `LoadLab3Data` (Domain) → `Lab3Repository` (contract Domain) → `Lab3RepositoryImpl` și `Lab3RemoteDataSource` (Data). Data Source face requesturile HTTP și decodează JSON-ul; repository-ul mapează răspunsurile în modelele folosite de interfață. Stările de încărcare și eroare sunt afișate de ecran, iar butonul „Reîncearcă” reia încărcarea.

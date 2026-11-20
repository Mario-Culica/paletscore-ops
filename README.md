# PaletScore

Prototip web pentru AI-Powered Business Challenge 2026 (secțiunea Studenți, tema Tech-Con / paletizare UR20).
Simulează secundă cu secundă o celulă UR20 cu două poziții și arată ce merită schimbat în fabrică.

**Aplicația:** https://razvanalecse.github.io/paletscore/

**Pitch-ul:** https://razvanalecse.github.io/paletscore/pitch/ (săgețile schimbă slide-ul, F pentru ecran complet; generat din `pitch/src` cu `python3 build_pitch.py`)

**Cine e cine:** utilizatorul este directorul de producție dintr-o fabrică alimentară, care își testează linia gratuit; clientul este Tech-Con, care plătește aplicația din bugetul de promovare și primește cererile.

## Cum testezi (2 minute)
1. **Demo 45 s**: flux stabil → schimbare în 7 minute → primul blocaj → intervenția recomandată pe aceeași oră.
2. **Primul blocaj** (scenariul „Schimbare lentă”): minutul 12:02. Apasă pe palet sau pe robot pentru Inspector și pentru „Unde merită să intervii?”.
3. **Ținta**: „Vreau minimum 430 de găleți/oră” → schimbare de cel mult 6 min 09 s → „Rulează la limită” → „+30 s” (401 găleți).
4. **Cronometru**: „Încarcă 8 observații demonstrative” → aplicația separă așteptarea operatorului de operație și spune ce contează mai mult.
5. **Plan comercial**: modifică bugetul pe canale și ratele; calendarul arată câte celule ajung livrate până la 31 decembrie.
6. Caz cu date greșite: `-3` sau `abc` la debit → mesaj de corectare, simularea nu pornește.

## Roluri și asistent (clona)
La deschidere aplicația cere autentificarea. Prima dată se creează contul de administrator.
- **Muncitor** (intră cu numele + PIN de 4 cifre): interfață simplă, făcută pentru telefon — cronometru cu 3 butoane mari (paletul e plin → încep schimbarea → poziția e liberă), butoane pentru a anunța o problemă (robot oprit, transportor plin, lipsă paleți, ambalaj defect, accident/pericol, altceva) și asistentul.
- **Administrator** (director de producție, director financiar, responsabil SSM, șef de tură; intră cu parolă): toată aplicația de simulare, plus secțiunea „Administrare” — echipa (adaugă/dezactivează/șterge, PIN sau parolă nouă), măsurătorile muncitorilor (mediane, export CSV, „Folosește mediana în simulare”), problemele anunțate (văzut / rezolvat) și setările asistentului. Fiecare director vede din prima secțiunea „trei decidenți” pe funcția lui.
- **Asistentul** (butonul „Asistent”, pentru ambele roluri): în mod local răspunde din reguli și din modelul de simulare (starea liniei, primul blocaj, intervenția recomandată, cât timp e pentru schimb, măsurători, probleme). Opțional, administratorul poate pune o cheie API Anthropic și asistentul folosește Claude (`claude-opus-5-5`) cu datele aplicației în context; dacă apelul nu reușește, revine la răspunsul local.

Limite: nu există server. Conturile, măsurătorile și problemele stau în `localStorage`, deci doar pe dispozitivul și browserul respectiv; muncitorul și administratorul trebuie să folosească același dispozitiv ca să vadă aceleași date. Cheia API rămâne în browser — bun pentru test, nu pentru producție. Pentru fabrică e nevoie de un backend (conturi, bază de date comună, apelurile către Claude făcute de server).

## Fișiere
- `roles.js`, `roles.css` — autentificarea, interfața muncitorului, panoul de administrare și asistentul
- `build.ps1` — echivalentul lui `build.sh` pentru Windows (`powershell -ExecutionPolicy Bypass -File build.ps1`)
- `model.js` — modelul de calcul unic (simulare, buffer, operatori, variație cu sămânță fixă, prag, țintă, intervenții, pâlnie, livrări)
- `paletscore.html` — interfața
- `test.js` — teste numerice (`node test.js`)
- `build.sh` — generează `dist/` pentru GitHub Pages / Netlify / Vercel
- `Model_financiar_PaletScore.xlsx` — modelul financiar editabil, cu formule (generat de `build_xlsx.py`)

Reperele PURATOS (7,4 și 8,6 găleți/min; 44 și 100 găleți/palet) sunt rezultate de test, nu garanții. Toate datele sunt fictive.

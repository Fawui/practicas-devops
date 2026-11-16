\# Notas — Introducción a Git (Microsoft Learn)



Módulo completado como parte de la ruta DevOps.



\## 1. Conceptos clave

\* \*\*Control de versiones (SCM):\*\* Con el control de versiones se tiene un historial de cambios sumamente importante para poder experimentar nuevas funcionalidades sin riesgo, trabajar en equipo y poder tener todo mas organizado

\* \*\*Git vs. GitHub:\*\* En Git uno "clona" un repositorio para poder trabajarlo localmente, en cambio en GitHub se unifica todo en un repositorio remoto para poder utilizar con mas gente.



\## 2. Flujo de trabajo que practiqué en el laboratorio

\* \*\*Clonar y configurar:\*\*

&#x20; \* `git clone <url>` — Clona el repositorio.

&#x20; \* `git status` — Muestra el estado del repo.

\* \*\*Guardar cambios en el historial:\*\*

&#x20; \* `git add <archivo>` — prepara los archivos para poder commitearlos.

&#x20; \* `git commit -m "mensaje"` — Es importante tener nombres descriptivos en cada commit para después no marearse.

\* \*\*Ramas (Branches) y Fusión:\*\*

&#x20; \* `git checkout -b <rama>` / `git switch -c <rama>` — Se crean ramas para poder trabajar en nuevas funcionalidades o trabajar en paralelo.

&#x20; \* `git merge <rama>` — Integra los cambios de una rama al main o a otra rama.

\* \*\*Sincronización con remoto:\*\*

&#x20; \* `git push` / `git pull` — Sube y baja los cambios del repo remoto.



\## 3. Evidencia práctica

\* \*\*Repositorio del ejercicio guiado:\*\* \ https://github.com/Fawui/skills-introduction-to-git

\* \*\*Lo que más me sirvió :\*\* Es la primera vez que utilice GitHub actions y fue gratificante como iba validando los cambios que iba realizando


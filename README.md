# Rose — versión web romántica

Esta adaptación conserva el render de Pygame/NumPy y usa **Pygbag** para ejecutarlo en el navegador con WebAssembly. La página exterior aporta el diseño romántico y mantiene ocultos los controles visuales.

## Requisitos

- Python 3.11 o 3.12 recomendado para la herramienta de empaquetado.
- `pip` y conexión a internet durante la instalación y la primera compilación.
- Navegador moderno basado en Chromium, Firefox o Safari reciente.

> Pygbag ejecuta Pygame-CE en WebAssembly. El proyecto original usa NumPy; la disponibilidad de su wheel compatible con el runtime de Pygbag debe comprobarse al compilar. Si el empaquetador informa que NumPy no está disponible para WebAssembly, consulta la sección “Compatibilidad de NumPy”.

## Estructura

```text
rose-web/
├── main.py
├── index.html
├── requirements.txt
├── build-site.sh
├── .gitignore
└── README.md
```

## 1. Instalar dependencias en Linux

Se recomienda un entorno virtual:

```bash
cd rose-web
python -m venv .venv
source .venv/bin/activate
python -m pip install --upgrade pip
python -m pip install -r requirements.txt
```

En CachyOS/Arch, si tu instalación bloquea pip global, usa siempre el entorno virtual como arriba.

## 2. Probar la animación en escritorio

```bash
python main.py
```

La versión de escritorio conserva los atajos originales:
- `Espacio`: pausa/reanuda.
- `R`: reinicia el ciclo.
- `S`: captura de pantalla en escritorio.
- `Esc`: salir.

En la versión web no se muestran botones. La animación comienza automáticamente y se repite cada 20 segundos. Los atajos de teclado pueden no estar disponibles en móviles; no son necesarios para la reproducción automática.

## 3. Probar en navegador

Instala Pygbag:

```bash
python -m pip install --upgrade pygbag
```

Desde la carpeta que contiene `rose-web`, ejecuta:

```bash
python -m pygbag rose-web
```

Abre `http://localhost:8000` en el navegador. La primera carga puede tardar porque Pygbag descarga el runtime de Python/Pygame WebAssembly. La documentación recomienda esperar a que termine la carga inicial.

## 4. Construir el sitio para publicar

Desde la raíz del proyecto:

```bash
chmod +x build-site.sh
./build-site.sh
```

El script empaqueta el juego y prepara `site/`:
- `site/index.html`: página romántica.
- `site/game/`: runtime web generado por Pygbag.

Después puedes probar el resultado localmente con un servidor estático:

```bash
cd site
python -m http.server 8080
```

Abre `http://localhost:8080`.

No abras `index.html` haciendo doble clic (`file://`): WebAssembly y los recursos del juego necesitan servirse por HTTP/HTTPS.

## 5. Publicar gratis con GitHub Pages

1. Crea un repositorio público en GitHub, por ejemplo `rose-web`.
2. Copia **el contenido de la carpeta `site/`** a la raíz del repositorio, o publica esa carpeta mediante GitHub Actions.
3. En GitHub, entra a **Settings → Pages**.
4. En “Build and deployment”, selecciona **Deploy from a branch**.
5. Selecciona la rama `main` y la carpeta `/ (root)` si subiste el contenido de `site/` a la raíz.
6. Guarda y espera a que GitHub Pages publique la dirección.

También puedes publicar `site/` con Netlify o Cloudflare Pages. Debes subir la carpeta `site` completa, no solamente el `index.html`.

## Compatibilidad de NumPy

La animación depende intensivamente de NumPy para geometría, arrays y renderizado. Pygbag soporta Pygame-CE, pero los paquetes binarios de terceros deben tener un wheel WebAssembly compatible con la versión de Python que carga el runtime. Por eso, la compilación de esta animación debe considerarse **pendiente de verificación en el entorno Pygbag** hasta que `python -m pygbag rose-web` termine sin errores y la rosa aparezca en el navegador.

Si el error menciona `numpy` o un módulo binario no disponible:
1. No cambies el código artístico todavía.
2. Comprueba la versión de Python/WebAssembly indicada en el error y las wheels disponibles en la documentación de Pygbag.
3. Si no existe wheel compatible, habrá que compilar NumPy para el runtime de Pygbag o portar el cálculo numérico a JavaScript. No basta con instalar NumPy en el entorno virtual del escritorio.

## Notas sobre la adaptación

- Se mantiene la geometría, la floración, los brillos, las gotas, el polvo, los reflejos y el estilo ASCII del original.
- El bucle principal se convirtió en `async` y cede el control con `await asyncio.sleep(0)`, requisito de Pygbag.
- El guardado de capturas se omite en WebAssembly porque el código original escribe en el sistema de archivos local del equipo.
- Se conserva el crédito del código original. Añade el `LICENSE.txt` original de JIN2 al proyecto antes de redistribuirlo; la cabecera indica uso personal y remite a esa licencia.

## Fuentes

- Pygbag: https://pygame-web.github.io/wiki/pygbag/
- Repositorio oficial: https://github.com/pygame-web/pygbag
- FAQ y compatibilidad de módulos: https://pygame-web.github.io/wiki/pygbag-code/

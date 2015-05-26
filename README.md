# cortana-hubot
![Heroku](https://heroku-badge.herokuapp.com/?app=cortana-hubot-slack)

Para a HPB se divertir e ter uma ajuda no [Slack][slack], o bot **cortana** foi criado. Ele é um bot de chat construído no framework [Hubot][hubot]. Foi inicialmente gerado pelo [generator-hubot][generator-hubot], e configurado para ser lançado no [Heroku][heroku] para ser usado o mais fácil e cedo possível.

Este README se destina a ajudar você a começar. Atualizar e melhorar o bot, como usar, implantar e atualizar, suas funcionalidades, etc!

[heroku]: http://www.heroku.com
[hubot]: http://hubot.github.com
[generator-hubot]: https://github.com/github/generator-hubot
[slack]: https://slack.com/

### Executando cortana localmente

Você pode testar seu hubot executando o comando a seguir, entretanto, alguns plugin podem não se comportar como esperado a menos que as [environment variables](#configuration) necessárias estejam devidamente configuradas.

Você pode iniciar cortana localmente com o comando:

    $ bin/hubot

Você verá uma informação de output inicial e um prompt:

    [Sat Feb 28 2015 12:38:27 GMT+0000 (GMT)] INFO Using default redis on localhost:6379
    cortana>

Agora você pode interagir com cortana executando `cortana help`.

    cortana> cortana help
    cortana animate me <query> - The same thing as `image me`, except adds [snip]
    cortana help - Displays all of the help commands that cortana knows about.
    ...

### Configuração

Alguns scripts (incluindo uns instalados por padrão) requerem environment variables para ser definido como uma simples forma de configuração.

Cada script deve ter um cabeçalho de comentário que contém uma seção de "Configuration" que explica que ele requer para ser definido em cada variável. Quando você tem muitos scripts instalados, esse processo pode ser bem intenso. O comando de shell seguinte pode ser usado como um "tapa buraco" até ser implementada uma forma mais fácil de realizar esta ação.

    grep -o 'hubot-[a-z0-9_-]\+' external-scripts.json | \
      xargs -n1 -i sh -c 'sed -n "/^# Configuration/,/^#$/ s/^/{} /p" \
          $(find node_modules/{}/ -name "*.coffee")' | \
        awk -F '#' '{ printf "%-25s %s\n", $1, $2 }'

Como definir environment variables será específico para seu sistema operacional. Em vez de recriar os vários métodos e melhores práticas para a concretização disso,
é sugerido que você procure por um guia dedicado focado em seu sistema operacional.

### Scripting

Um script de exemplo é incluído em `scripts/example.coffee`, então cheque-o para começar, juntamente com o [Scripting Guide](scripting-docs).

Para muitas tarefas comuns, existe uma boa chance de alguém já possui um script que o faça.

[scripting-docs]: https://github.com/github/hubot/blob/master/docs/scripting.md

### external-scripts

Inevitávelmente haverá funcionalidades que todo mundo irá querer. Ao invés de escrevê-las por si só, você pode usar plugins existentes.

Hubot é capaz de carregar plugins de pacotes `npm` de terceiros. Isso é um caminho recomendado para adicionar funcionalidades para seu Hubot. Você pode obter uma lista de plugins disponíveis para o hubot em  [npmjs.com](npmjs) ou usando `npm search`:

    % npm search hubot-scripts panda
    NAME             DESCRIPTION                        AUTHOR DATE       VERSION KEYWORDS
    hubot-pandapanda a hubot script for panda responses =missu 2014-11-30 0.9.2   hubot hubot-scripts panda
    ...


Para usar um pacote, cheque a sua documentação, mas no geral é assim:

1. Use `npm install --save`  para adicionar o pacote em `package.json` e instalá-lo;
2. Adicione o nome do pacote em `external-scripts.json` como uma string de aspas duplas.

Você pode revisar o arquivo `external-scripts.json` para ver o que já é incluido por padrão.

##### Uso Avançado

Também é possível definir `external-scripts.json` como um objeto para específicar explicitamente que scripts de um pacote devem ser incluídos. O exemplo abaixo, por exemplo, apenas ativará dois de seis scripts disponíveis dentro do plugin `hubot-fun`, mas também todos os quatro em `hubot-auto-deploy`.

```json
{
  "hubot-fun": [
    "crazy",
    "thanks"
  ],
  "hubot-auto-deploy": "*"
}
```

**Esteja avisado de que nem todos plugins suportam esse uso, e geralmente irão falhar ao incluir todos os scripts.**

[npmjs]: https://www.npmjs.com

### hubot-scripts

Antes dos pacotes de plugins do hubot serem adotados, a maioria dos plugins eram guardados no pacote
[hubot-scripts][hubot-scripts]. Alguns desses plugins tiveram que migrar para seus próprios pacotes. Eles ainda podem ser usados, mas a configuração é um pouco diferente.

Para permitir scripts do pacote hubot-scripts, adicione o nome do script com sua extenção como uma string de aspas duplas no arquivo `hubot-scripts.json` deste repositório.

[hubot-scripts]: https://github.com/github/hubot-scripts

##  Persistência

Se você irá usar o pacote `hubot-redis-brain` (fortemente recomendável), você irá precisar adicionar o addon Redit to Go no Heroku, que requer uma conta verificada, ou criar uma conta no [Redis to Go][redistogo] e manualmente configurar a variável `REDISTOGO_URL`.

    % heroku config:add REDISTOGO_URL="..."

Se você não precisar de nenhuma persistência sinta-se livre para remover `hubot-redis-brain`
do arquivo `external-scripts.json` e não precisará se preocupar com redis de forma alguma.

[redistogo]: https://redistogo.com/

## Adapters (adpatadores)

Adapters são a interface para o serviço que você quer que o hubot execute, como o Campfire, IRC ou Slack. Há vários adapters de terceiros com os quais a comunidade contribui. Cheque [Hubot Adapters][hubot-adapters] para ver os disponíveis.

Se você quiser executar um adapter que não é do Campfire, ou da shell, você precisará adicionar o pacote do adaptador como uma dependência no arquivo `package.json` na seção `dependencies`.

Once you've added the dependency with `npm install --save` to install it you
can then run hubot with the adapter.

    % bin/hubot -a <adapter>

Where `<adapter>` is the name of your adapter without the `hubot-` prefix.

[hubot-adapters]: https://github.com/github/hubot/blob/master/docs/adapters.md

## Deployment

    % heroku create --stack cedar
    % git push heroku master

If your Heroku account has been verified you can run the following to enable
and add the Redis to Go addon to your app.

    % heroku addons:add redistogo:nano

If you run into any problems, checkout Heroku's [docs][heroku-node-docs].

You'll need to edit the `Procfile` to set the name of your hubot.

More detailed documentation can be found on the [deploying hubot onto
Heroku][deploy-heroku] wiki page.

### Deploying to UNIX or Windows

If you would like to deploy to either a UNIX operating system or Windows.
Please check out the [deploying hubot onto UNIX][deploy-unix] and [deploying
hubot onto Windows][deploy-windows] wiki pages.

[heroku-node-docs]: http://devcenter.heroku.com/articles/node-js
[deploy-heroku]: https://github.com/github/hubot/blob/master/docs/deploying/heroku.md
[deploy-unix]: https://github.com/github/hubot/blob/master/docs/deploying/unix.md
[deploy-windows]: https://github.com/github/hubot/blob/master/docs/deploying/unix.md

## Campfire Variables

If you are using the Campfire adapter you will need to set some environment
variables. If not, refer to your adapter documentation for how to configure it,
links to the adapters can be found on [Hubot Adapters][hubot-adapters].

Create a separate Campfire user for your bot and get their token from the web
UI.

    % heroku config:add HUBOT_CAMPFIRE_TOKEN="..."

Get the numeric IDs of the rooms you want the bot to join, comma delimited. If
you want the bot to connect to `https://mysubdomain.campfirenow.com/room/42`
and `https://mysubdomain.campfirenow.com/room/1024` then you'd add it like
this:

    % heroku config:add HUBOT_CAMPFIRE_ROOMS="42,1024"

Add the subdomain hubot should connect to. If you web URL looks like
`http://mysubdomain.campfirenow.com` then you'd add it like this:

    % heroku config:add HUBOT_CAMPFIRE_ACCOUNT="mysubdomain"

[hubot-adapters]: https://github.com/github/hubot/blob/master/docs/adapters.md

## Restart the bot

You may want to get comfortable with `heroku logs` and `heroku restart` if
you're having issues.

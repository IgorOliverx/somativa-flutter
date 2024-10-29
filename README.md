<h1>Relatório das Funcionalidades Implementadas e Decisões de Design</h1>

<h3>1.1 Autenticação Biométrica e por Senha </h3>
O aplicativo utiliza a biblioteca `local_auth` para autenticação biométrica, oferecendo aos usuários a opção de usar impressão digital. Alternativamente, há a opção de login por senha, útil em casos onde o sensor de impressão digital não está disponível ou o usuário prefere outro método. Essa abordagem garante flexibilidade e segurança, permitindo o uso de autenticação multifatorial.

<h3>1.2 Verificação de Localização</h3>
A biblioteca `geolocator` foi escolhida para a verificação de localização, validando se o usuário está em uma área permitida. Após autenticação bem-sucedida, o aplicativo verifica a latitude e longitude do dispositivo em relação a um perímetro predefinido. Esta verificação ocorre em segundo plano, mantendo a experiência do usuário rápida e segura.

<h3>1.3 Registro de Acessos</h3> 
Cada tentativa de acesso é registrada com dados como data, hora e localização. Esses dados são enviados para o servidor por meio da API personalizada em JSON e armazenados no banco de dados, o que possibilita monitoramento e auditoria de acessos. A API permite a comunicação centralizada, e a estrutura dos dados (tabelas `users` e `access_logs`) foi projetada para garantir o armazenamento seguro e eficiente.

<h3>1.4 API Personalizada</h3> 
A API JSON serve para gerenciar usuários e registrar acessos. Para isso, foi decidido usar autenticação baseada em tokens para cada requisição à API, reforçando a segurança das operações. Além disso, foram configurados endpoints RESTful que seguem as convenções HTTP, facilitando a manutenção e integração futura.


 <h2>2. Especificação do Uso de APIs Externas e Integração com Firebase</h2>

<h3>2.1 Geolocalização e Autenticação Biométrica </h3>
Para obter a localização e autenticação biométrica, utilizamos as bibliotecas `geolocator` e `local_auth`, respectivamente. Esses pacotes facilitam a integração com as funcionalidades do dispositivo e garantem conformidade com as permissões necessárias para acesso a dados sensíveis.

<h3>2.2 Integração com Firebase </h3>
O Firebase é usado para armazenar dados críticos de autenticação e logs. Com ele, o aplicativo armazena os registros de acesso de forma segura, mantendo a escalabilidade. A autenticação do Firebase também facilita o login, pois permite métodos adicionais como autenticação por Google, e-mail, etc.

<h3>2.3 API Personalizada </h3>
A API JSON personalizada foi implementada para manipular dados de usuários e logs de acesso de forma centralizada. A comunicação ocorre por meio de requisições HTTP, onde o Firebase faz a intermediação da autenticação, e os dados do usuário e logs são manipulados no banco de dados seguro (MongoDB ou PostgreSQL, dependendo da configuração escolhida).



 <h2>3. Desafios Encontrados e Como Foram Resolvidos</h2>

<h3>3.1 Gerenciamento de Permissões e Autenticação Biométrica </h3>
Em alguns dispositivos, a autenticação biométrica apresentou problemas de permissão ou incompatibilidade. Este problema foi resolvido ajustando as permissões de acesso e testando em múltiplos dispositivos físicos para garantir o suporte a sensores variados de biometria (Face ID, impressão digital).

<h3>3.2 Precisão de Localização e Consumo de Bateria </h3>
Para evitar o consumo excessivo de bateria, a verificação de localização foi configurada para verificar apenas no momento do login, em vez de monitorar constantemente. A precisão de localização também foi ajustada para equilibrar entre consumo e eficiência, garantindo que o usuário esteja realmente dentro da área permitida sem afetar a performance.

<h3>3.3 Sincronização de Dados e Segurança de API </h3>
A sincronização dos registros entre o aplicativo e o banco de dados foi desafiadora, especialmente em áreas com baixa conexão. Para isso, implementamos um sistema de filas que reenvia automaticamente os registros de acesso quando a conexão é restabelecida, garantindo que nenhum dado seja perdido. Além disso, a API foi reforçada com autenticação por token para garantir que apenas acessos autenticados pudessem enviar ou receber dados.



<h2>Conclusão</h2>
O aplicativo de Controle de Acesso foi implementado com sucesso, integrando autenticação biométrica e verificação de localização para garantir a segurança dos acessos a áreas restritas. Com a API personalizada e integração ao Firebase, o gerenciamento de dados de usuários e logs de acesso foi facilitado, enquanto a estrutura modular garante a flexibilidade e escalabilidade do sistema. A solução final oferece uma interface robusta, segura e fácil de usar, com extensibilidade para futuras implementações de novos métodos de autenticação e verificação de segurança.




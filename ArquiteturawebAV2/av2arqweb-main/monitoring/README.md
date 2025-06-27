# 📊 Monitoramento da API Spring Boot

Este diretório contém a configuração completa para monitorar a API Spring Boot usando **Prometheus** e **Grafana**.

## 🏗️ Estrutura do Projeto

```
monitoring/
├── docker-compose.yml                    # Orquestração dos serviços
├── prometheus/
│   └── prometheus.yml                    # Configuração do Prometheus
├── grafana/
│   ├── provisioning/
│   │   ├── datasources/
│   │   │   └── prometheus.yml           # Datasource do Prometheus
│   │   └── dashboards/
│   │       └── dashboard.yml            # Configuração de dashboards
│   └── dashboards/
│       └── spring-boot-api-dashboard.json # Dashboard da API
└── README.md                            # Este arquivo
```

## 🚀 Como Iniciar o Ambiente de Monitoramento

### Pré-requisitos
- Docker e Docker Compose instalados
- API Spring Boot rodando na porta 8080

### 1. Iniciar os Serviços
```bash
cd monitoring
docker-compose up -d
```

### 2. Verificar se os Serviços Estão Rodando
```bash
docker-compose ps
```

## 🌐 Acessos

### Prometheus
- **URL:** http://localhost:9090
- **Funcionalidades:** 
  - Visualizar métricas coletadas
  - Executar queries PromQL
  - Configurar alertas

### Grafana
- **URL:** http://localhost:3000
- **Credenciais:** 
  - Usuário: `admin`
  - Senha: `admin123`
- **Funcionalidades:**
  - Dashboards pré-configurados
  - Visualizações em tempo real
  - Alertas e notificações

## 📈 Dashboard Incluído

O dashboard **"Spring Boot API - AuthenticUser"** inclui:

### Métricas de Performance
- **HTTP Requests Total** - Requisições por segundo
- **HTTP Response Time** - Tempo de resposta (95th percentile)
- **HTTP Status Codes** - Distribuição de códigos de status
- **Response Time Distribution** - Distribuição de tempos de resposta

### Métricas do Sistema
- **JVM Memory Usage** - Uso de memória heap
- **JVM Threads** - Número de threads ativas
- **System CPU Usage** - Uso de CPU
- **Application Uptime** - Tempo de atividade da aplicação

### Métricas de Banco de Dados
- **Database Connections** - Conexões ativas do HikariCP

## 🔧 Configuração do Prometheus

O Prometheus está configurado para coletar métricas de:

1. **API Spring Boot** (`host.docker.internal:8080/actuator/prometheus`)
2. **Próprio Prometheus** (métricas internas)
3. **Node Exporter** (opcional, para métricas do sistema)

### Configurações Importantes:
- **Intervalo de coleta:** 10 segundos para a API
- **Timeout:** 5 segundos
- **Retenção de dados:** 200 horas

## 🛠️ Troubleshooting

### Problema: Prometheus não consegue acessar a API
**Solução:** Verifique se a API está rodando e acessível em `localhost:8080`

### Problema: Grafana não mostra dados
**Solução:** 
1. Verifique se o datasource Prometheus está configurado
2. Confirme se o Prometheus está coletando métricas
3. Verifique se as queries estão corretas

### Problema: Dashboard não aparece
**Solução:** 
1. Reinicie o Grafana: `docker-compose restart grafana`
2. Verifique se o arquivo JSON do dashboard está correto

## 📊 Métricas Disponíveis

### HTTP Metrics
- `http_server_requests_seconds_count` - Contador de requisições
- `http_server_requests_seconds_sum` - Soma dos tempos de resposta
- `http_server_requests_seconds_bucket` - Histograma de tempos

### JVM Metrics
- `jvm_memory_used_bytes` - Memória usada
- `jvm_memory_max_bytes` - Memória máxima
- `jvm_threads_live_threads` - Threads ativas

### System Metrics
- `system_cpu_usage` - Uso de CPU
- `process_uptime_seconds` - Tempo de atividade

### Database Metrics
- `hikaricp_connections_active` - Conexões ativas
- `hikaricp_connections_idle` - Conexões ociosas

## 🔄 Comandos Úteis

```bash
# Iniciar serviços
docker-compose up -d

# Parar serviços
docker-compose down

# Ver logs
docker-compose logs -f prometheus
docker-compose logs -f grafana

# Reiniciar um serviço específico
docker-compose restart prometheus

# Remover volumes (cuidado: apaga dados)
docker-compose down -v
```

## 🎯 Próximos Passos

1. **Configurar Alertas** no Prometheus
2. **Criar Dashboards Customizados** no Grafana
3. **Implementar Métricas Customizadas** na API
4. **Configurar Notificações** (email, Slack, etc.)
5. **Monitorar Logs** com ELK Stack

---

**🎉 Seu ambiente de monitoramento está pronto!** 
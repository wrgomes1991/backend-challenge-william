
{{/* Defina a função para gerar o nome completo da aplicação */}}
{{- define "backend-app.fullname" -}}
{{- printf "%s-%s" .Release.Name .Chart.Name -}}
{{- end -}}

{{/* Defina a função para obter o nome do aplicativo */}}
{{- define "backend-app.name" -}}
{{- printf "%s" .Chart.Name -}}
{{- end -}}

cluster:
	kind create cluster || true

argocd: cluster
	kubectl create namespace argo-cd || true
	kustomize build . | kubectl apply -n argo-cd -f -

password:
	@kubectl view-secret argocd-initial-admin-secret -n argo-cd --quiet

argocd-uninstall:
	kubectl delete namespace argo-cd

clean:
	kind delete cluster

appset-dev:
	kustomize build appsets/overlays/development/

appset-prod:
	kustomize build appsets/overlays/production/

deploy-dev:
	kustomize build appsets/overlays/development/ | kubectl apply -f -

deploy-prod:
	kustomize build appsets/overlays/production/ | kubectl apply -f -

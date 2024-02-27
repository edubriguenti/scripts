#!/bin/bash

# Defina a lista de repositórios
repositories=("repo1" "repo2" "repo3")

# Função para criar branches de release em diferentes repositórios
create_release_branch() {
    local release_branch=$1
    for repo in "${repositories[@]}"
    do
        git -C $repo checkout -b $release_branch
        git -C $repo push origin $release_branch
        echo "Branch de release $release_branch criada em $repo"
    done
}

# Função para fazer o merge das branches de release no branch master
merge_release_to_master() {
    local release_branch=$1
    for repo in "${repositories[@]}"
    do
        git -C $repo checkout master
        git -C $repo merge --no-ff $release_branch
        git -C $repo push origin master
        echo "Merge da branch de release $release_branch em master concluído em $repo"
    done
}

# Menu de opções
echo "Selecione uma opção:"
echo "1. Criar branches de release"
echo "2. Fazer merge das branches de release na master"
read -p "Opção: " option

# Executar a opção selecionada
case $option in
    1) 
        read -p "Digite o nome da branch de release que deseja criar: " release_branch
        create_release_branch $release_branch
        ;;
    2)
        read -p "Digite o nome da branch de release que deseja fazer merge com a master: " release_branch
        merge_release_to_master $release_branch
        ;;
    *)
        echo "Opção inválida. Saindo."
        exit 1
        ;;
esac

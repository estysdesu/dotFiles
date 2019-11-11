set -e

cloudProjDir="$(dirname "$(readlink -f $0)")"
localProjDir="$HOME/projects"

IFS=$'\n'
for cpd in `find "$cloudProjDir" -type d -maxdepth 1`; do
	echo "Linking $cpd"
	ln -sfn "$cpd" "$localProjDir"/
done

for cpf in `find "$cloudProjDir" -type f -maxdepth 1`; do
	echo "Linking $cpf"
	ln -sf "$cpf" "$localProjDir"/
done

#! /bin/sh

echo "CI_REGISTRY=${{ secrets.CI_REGISTRY }}"
echo "CI_REGISTRY_USER=${{ secrets.CI_REGISTRY_USER }}"
echo "CI_REGISTRY_TOKEN=${{ secrets.CI_REGISTRY_TOKEN }}"
echo "CI_IMAGE_TAG=development"
echo "GH_REPOSITORY=${{ secrets.GH_REPOSITORY }}"

echo "DEBUG=0" >> .env
echo "DJANGO_SETTINGS_MODULE=django_project.production_settings" >> .env
echo "SECRET_KEY=${{ secrets.SECRET_KEY }}" >> .env
echo "DJANGO_ALLOWED_HOSTS=${{ secrets.DJANGO_ALLOWED_HOSTS }}" >> .env

echo "DATABASE_ENGINE=${{ secrets.DATABASE_ENGINE }}" >> .env
echo "MYSQL_DATABASE=${{ secrets.MYSQL_DATABASE }}" >> .env
echo "MYSQL_USER=${{ secrets.MYSQL_USER }}" >> .env
echo "MYSQL_PASSWORD=${{ secrets.MYSQL_PASSWORD }}" >> .env
echo "MYSQL_HOSTNAME=${{ secrets.MYSQL_HOSTNAME }}" >> .env
echo "MYSQL_PORT=${{ secrets.MYSQL_PORT }}" >> .env
echo "MYSQL_ROOT_PASSWORD=${{ secrets.MYSQL_ROOT_PASSWORD }}" >> .env
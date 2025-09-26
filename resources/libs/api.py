import requests
from robot.api.deco import keyword
from robot.libraries.BuiltIn import BuiltIn

def get_api_url():
    return BuiltIn().get_variable_value("${API_URL}")

@keyword('Create User Via API')
def create_user(user_data):
    url = f"{get_api_url()}/usuarios"
    response = requests.post(url, json=user_data)
    return response.json()

@keyword('Login Via API')
def login_api(email, password):
    url = f"{get_api_url()}/login"
    payload = {"email": email, "password": password}
    response = requests.post(url, json=payload)
    return response.json()

@keyword('Create Product Via API')
def create_product(product_data, token):
    url = f"{get_api_url()}/produtos"
    headers = {"Authorization": token}
    response = requests.post(url, json=product_data, headers=headers)
    return response.json()

@keyword('Delete Product Via API')
def delete_product(product_id, token):
    url = f"{get_api_url()}/produtos/{product_id}"
    headers = {"Authorization": token}
    response = requests.delete(url, headers=headers)
    return response.json()

@keyword('Delete User Via API')
def delete_user(user_id):
    url = f"{get_api_url()}/usuarios/{user_id}"
    response = requests.delete(url)
    return response.json()

@keyword('Get User By ID')
def get_user_by_id(user_id):
    url = f"{get_api_url()}/usuarios/{user_id}"
    response = requests.get(url)
    return response.status_code, response.json()

@keyword('Get Product By ID')
def get_product_by_id(product_id):
    url = f"{get_api_url()}/produtos/{product_id}"
    response = requests.get(url)
    return response.status_code, response.json()

@keyword('Get User By Email')
def get_user_by_email(email):
    url = f"{get_api_url()}/usuarios"
    response = requests.get(url)
    users = response.json()
    for user in users.get('usuarios', []):
        if user['email'] == email:
            return user
    return None

@keyword('Get Product By Name')
def get_product_by_name(name):
    url = f"{get_api_url()}/produtos"
    response = requests.get(url)
    products = response.json()
    for product in products.get('produtos', []):
        if product['nome'] == name:
            return product
    return None

@keyword('Create From Fixtures')
def create_from_fixtures(entity_type, fixture_type, token=None):
    from robot.libraries.BuiltIn import BuiltIn
    builtin = BuiltIn()

    data = builtin.run_keyword('Get Fixtures', entity_type, fixture_type)

    if entity_type == 'users':
        return create_user(data)
    elif entity_type == 'products':
        return create_product(data, token)

@keyword('Delete By Email From Fixtures')
def delete_entity_from_fixtures(entity_type, fixture_type, token=None):
    from robot.libraries.BuiltIn import BuiltIn
    builtin = BuiltIn()
    
    # Carregar dados do fixture
    data = builtin.run_keyword('Get Fixtures', entity_type, fixture_type)
    
    if entity_type == 'users':
        existing_entity = get_user_by_email(data['email'])
        if existing_entity:
            return delete_user(existing_entity['_id'])
    elif entity_type == 'products':
        existing_entity = get_product_by_name(data['nome'])
        if existing_entity:
            return delete_product(existing_entity['_id'], token)
    
    return {'message': f'{entity_type.capitalize()} não encontrado'}

# Manter compatibilidade com funções antigas
@keyword('Create User From Fixtures')
def create_user_from_fixtures(fixture_type):
    return create_from_fixtures('users', fixture_type)

@keyword('Delete User By Email From Fixtures')
def delete_user_by_email_from_fixtures(fixture_type):
    return delete_entity_from_fixtures('users', fixture_type)

@keyword('Create Product From Fixtures')
def create_product_from_fixtures(fixture_type, token):
    return create_from_fixtures('products', fixture_type, token)

@keyword('Delete Product By Name From Fixtures')
def delete_product_by_name_from_fixtures(fixture_type, token):
    return delete_entity_from_fixtures('products', fixture_type, token)

@keyword('Setup Admin And Get Token')
def setup_admin_and_get_token(fixture_type='admin'):
    from robot.libraries.BuiltIn import BuiltIn
    builtin = BuiltIn()
    
    # Limpar e criar admin
    delete_entity_from_fixtures('users', fixture_type)
    create_from_fixtures('users', fixture_type)
    
    # Obter dados e fazer login
    admin_data = builtin.run_keyword('Get Fixtures', 'users', fixture_type)
    login_response = login_api(admin_data['email'], admin_data['password'])
    
    return login_response['authorization']
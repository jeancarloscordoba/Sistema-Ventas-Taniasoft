
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.3.1/dist/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
        <title>Productos</title>
    </head>
    <body>
        <div class="d-flex">
            <div class="card col-sm-4">
                <div class="card-body">
                    <form action="Controlador?menu=Producto" method="POST"> <!-- FORMULARIO PARA INGRESAR UN NUEVO PRODUCTO -->
                        <!-- Campo para los Nombres -->
                        <div class="form-group">
                            <label>Nombres</label>
                            <input type="text" value="${not empty producto ? producto.getNom() : ''}" name="txtNombres" class="form-control"> 
                        </div>
                        <!-- Campo para el Precio -->
                        <div class="form-group">
                            <label>Precio</label>
                            <input type="text" value="${not empty producto ? producto.getPrecio() : ''}" name="txtPrecio" class="form-control"> 
                            <!-- Mensaje de error para el campo Precio -->
                            <div class="text-danger" id="mensajeErrorPrecio">
                                ${mensajeErrorPrecio}
                                <script>
                                    // Función para ocultar el mensaje de error después de 7 segundos
                                    setTimeout(function () {
                                        document.getElementById('mensajeErrorPrecio').style.display = 'none';
                                    }, 20000); // Duración en milisegundos del mensaje de error
                                </script>
                            </div>
                        </div> 
                        <!-- Campo para la Stock -->
                        <div class="form-group">
                            <label>Stock</label>
                            <input type="text" value="${not empty producto ? producto.getStock() : ''}" name="txtStock" class="form-control"> 
                            <!-- Mensaje de error para el campo Stock -->
                            <div class="text-danger" id="mensajeErrorStock">
                                ${mensajeErrorStock}
                                <script>
                                    // Función para ocultar el mensaje de error después de 7 segundos
                                    setTimeout(function () {
                                        document.getElementById('mensajeErrorStock').style.display = 'none';
                                    }, 20000); // Duración en milisegundos del mensaje de error
                                </script>
                            </div>
                        </div>
                        <!-- Campo para los Descripcion -->
                        <div class="form-group">
                            <label>Descripcion</label>
                            <input type="text" value="${not empty producto ? producto.getDescripcion() : ''}" name="txtDescripcion" class="form-control"> 
                        </div>
                        <!-- Campo para el Estado -->
                        <div class="form-group">
                            <label>Estado</label>
                            <input type="text" value="${not empty producto ? producto.getEstado() : ''}" name="txtEstado" class="form-control">
                            <!-- Mensaje de error para el campo Estado -->
                            <div class="text-danger" id="mensajeErrorEstado">
                                ${mensajeErrorEstado}
                                <script>
                                    // Función para ocultar el mensaje de error después de 7 segundos
                                    setTimeout(function () {
                                        document.getElementById('mensajeErrorEstado').style.display = 'none';
                                    }, 20000); // Duración en milisegundos del mensaje de error
                                </script>
                            </div>
                        </div> 
                        <!-- BOTONES PARA GUARDAR y CANCELAR GUARDADO; ACTUALIZAR Y CANCELAR EDICIÓN -->
                        <div class="d-flex">
                            <!-- Mostrar el botón de "Guardar" solo cuando no se está editando un Producto -->
                            <c:if test="${empty editarProducto}">
                                <button type="submit" name="accion" style="margin-right: 6px" value="Guardar" class="btn btn-primary" onclick="return confirm('¿Estás seguro de GUARDAR este Producto?')">Guardar</button>
                                <button type="submit" name="accion" value="cancelarGuardado" class="btn btn-danger" onclick="return confirm('¿Estás seguro de CANCELAR el guardado del Producto?')">Cancelar</button>
                            </c:if>
                            <!-- Mostrar los botones de "Actualizar" y "Cancelar" solo cuando se está editando un Producto -->
                            <c:if test="${not empty editarProducto}">
                                <button type="submit" name="accion" style="margin-right: 6px" value="Actualizar" class="btn btn-success" onclick="return confirm('¿Estás seguro de ACTUALIZAR este Producto?')">Actualizar</button>
                                <button type="submit" name="accion" value="cancelarEdicion" class="btn btn-danger" onclick="return confirm('¿Estás seguro de CANCELAR la edición del Producto?')">Cancelar</button>
                            </c:if>
                        </div>
                    </form>
                </div>
            </div>
            <div class="col-sm-8" style="overflow-y: auto; max-height: 500px;">
                <table Class="table table-striped table-hover">
                    <thead>
                        <tr class="text-left"> 
                            <th scope="col">ID</th>
                            <th scope="col">NOMBRES</th>
                            <th scope="col">PRECIO</th>
                            <th scope="col">STOCK</th>
                            <th scope="col">DESCRIPCION</th>
                            <th scope="col">ESTADO</th>
                            <th scope="col">ACCIONES</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="pr" items="${productos}"> <!--El atributo productos se esta enviando desde el controlador.-->
                            <tr> <!-- ARROJAMIENTO DE LOS DATOS DE LOS CLIENTES AGREGADOS -->
                                <td>${pr.getId()}</td>
                                <td>${pr.getNom()}</td>
                                <td>${pr.getPrecio()}</td>
                                <td>${pr.getStock()}</td>
                                <td>${pr.getDescripcion()}</td>
                                <td>${pr.getEstado()}</td>
                                <td class="d-flex"> <!-- td PARA LOS BOTONES DE EDITAR Y ELIMINAR PRODUCTOS -->
                                    <a class="btn btn-warning" href="Controlador?menu=Producto&accion=Editar&id=${pr.getId()}" onclick="return confirm('¿Estás seguro de iniciar a EDITAR este Producto?')">Editar</a> 
                                    <a class="btn btn-danger" style="margin-left: 6px" href="Controlador?menu=Producto&accion=Delete&id=${pr.getId()}" onclick="return confirm('¿Estás seguro de ELIMINAR este Producto?')">Eliminar</a>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>          
        </div>

        <!-- MENSAJE EXITO EN LAS ACCIONES -->
        <!-- Mensaje de éxito al realizar una acción --> 
        <% String mensajeCorrecto = (String) request.getAttribute("mensajeCorrecto");
            if (mensajeCorrecto != null) {%>
        <div id="mensajeCorrecto" class="alert alert-success text-center" style="position: fixed; bottom: 0px; left: 50%; transform: translateX(-50%);" role="alert">
            <%= mensajeCorrecto%>
        </div>
        <script>
            // Función para ocultar el mensaje de éxito después de 6 segundos
            setTimeout(function () {
                document.getElementById('mensajeCorrecto').style.display = 'none';
            }, 7000); // Duración en milisegundos del mensaje de éxito
        </script>
        <%}%>

        <!-- MENSAJE EXITO EN LAS ACCIONES DE CANCELAR-->
        <!-- Mensaje de éxito al realizar una cancelacion --> 
        <% String mensajeCancelar = (String) request.getAttribute("mensajeCancelar");
            if (mensajeCancelar != null) {%>
        <div id="mensajeCancelar" class="alert alert-warning text-center" style="position: fixed; bottom: 0px; left: 50%; transform: translateX(-50%);" role="alert">
            <%= mensajeCancelar%>
        </div>
        <script>
            // Función para ocultar el mensaje de éxito después de 6 segundos
            setTimeout(function () {
                document.getElementById('mensajeCancelar').style.display = 'none';
            }, 7000); // Duración en milisegundos del mensaje de éxito
        </script>
        <%}%>

        <!-- MENSAJE DE ERROR EN LAS ACCIONES -->
        <!-- Mensaje de error al realizar una accion-->            
        <% String mensajeError = (String) request.getAttribute("mensajeError");
            if (mensajeError != null) {%>
        <div id="mensajeError" class="alert alert-danger text-center" style="position: fixed; bottom: 0px; left: 50%; transform: translateX(-50%);" role="alert">
            <%= mensajeError%>
        </div>
        <script>
            // Función para ocultar el mensaje de éxito después de 6 segundos
            setTimeout(function () {
                document.getElementById('mensajeError').style.display = 'none';
            }, 8000); // Duración en milisegundos del mensaje de éxito
        </script>
        <%}%>

        <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/popper.js@1.14.7/dist/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.3.1/dist/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
    </body>
</html>

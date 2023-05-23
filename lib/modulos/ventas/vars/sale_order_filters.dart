import 'package:fluent_ui/fluent_ui.dart';
import 'package:neo/core/utils/filter_model.dart';

const saleOrderEstateFilterItemsInitialValue = 'Pedido de Venta';
const List<FilterMenuItem> saleOrderEstateFilterItems = [
  FilterMenuItem(
    title: 'Todos',
    where: "",
  ),
  FilterMenuItem(
    title: 'Borrador',
    where: "('state','=','draft')",
  ),
  FilterMenuItem(
    title: 'Enviado',
    where: "('state','=','draft')",
  ),
  FilterMenuItem(
    title: 'Pedido de Venta',
    icon: FluentIcons.list,
    where: "('state','=','sale')",
  ),
  FilterMenuItem(
    title: 'Bloqueado',
    where: "('state','=','done')",
  ),
  FilterMenuItem(
    title: 'Esperando Aprobación',
    where: "('state','=','waiting_approval')",
  ),
  FilterMenuItem(
    title: 'Aprobado',
    icon: FluentIcons.list,
    where: "('state','=','approved')",
  ),
  FilterMenuItem(
    title: 'Hecho',
    icon: FluentIcons.list,
    where: "('state','=','posted')",
  ),
  FilterMenuItem(
    title: 'Rechazado',
    icon: FluentIcons.list,
    where: "('state','=','rejected')",
  ),
  FilterMenuItem(
    title: 'Cancelado',
    icon: FluentIcons.list,
    where: "('state','=','cancel')",
  ),
];

const saleOrderDespachoEstateFilterItemsInitialValue = 'Para despachar';
const List<FilterMenuItem> saleOrderDespachoEstateFilterItems = [
  FilterMenuItem(
    title: 'Todos',
    where: "",
  ),
  FilterMenuItem(
    title: 'Sin despachos',
    where: "('estado_despacho_filtro','=','Sin despachos')",
  ),
  FilterMenuItem(
    title: 'Borrador',
    where: "('estado_despacho_filtro','=','Borrador')",
  ),
  FilterMenuItem(
    title: 'Para despachar',
    icon: FluentIcons.list,
    where: "('estado_despacho_filtro','=','Para despachar')",
  ),
  FilterMenuItem(
    title: 'Despachado',
    where: "('estado_despacho_filtro','=','Despachado')",
  ),
  FilterMenuItem(
    title: 'Cancelado',
    where: "('estado_despacho_filtro','=','Cancelado')",
  ),
];
